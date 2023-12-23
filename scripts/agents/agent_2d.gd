extends RigidBody2D

class_name Agent2D

signal moved
signal turn_ended
signal statuses_changed(statuses: Array[AgentStatus])

@onready var collision_shape: CollisionShape2D = $CollisionShape2D

@export var starting_velocity: float = 5
@export var starting_health: int = 100
@export var starting_damage: int = 5
@export var max_status_count: int = 3

@export_category("Equipment")
@export var _head_place_holder: Node
@export var _right_hand_place_holder: Node
@export var _left_hand_place_holder: Node
@export var _legs_place_holder: Node

@export_category("VFX")
@export var collision_vfx_prefab: PackedScene
@export var wall_collision_vfx_prefab: PackedScene

var is_my_turn: bool
var moving: bool
var current_velocity: float
var max_health: int
var current_health: int
var current_damage: int
var previous_velocity: Vector2
var is_player: bool
var collision_pos : Vector2

var statuses: Array[AgentStatus] = []
var current_equipment : Dictionary = {}

var is_being_aimed: bool :
	set(value):
		is_being_aimed = value
		queue_redraw()
	get: return is_being_aimed

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	
	current_velocity = starting_velocity
	max_health = starting_health + get_total_health_bonus()
	current_health = max_health
	current_damage = starting_damage + get_total_damage_bonus()

func _physics_process(_delta) -> void:
	if linear_velocity.length_squared() > 2:
		moving = true
	elif linear_velocity.length_squared() < 2:
		moving = false
	previous_velocity = linear_velocity

func move(direction: Vector2) -> void:
	if is_my_turn:
		print(name, " is moving in direction=", direction, " speed=", current_velocity)
		apply_impulse(direction * current_velocity)
		moved.emit()

func start_turn() -> void:
	print(self.name, " turns has started")
	execute_all_effect_for_time(self, Effect.EffectTime.OnTurnStart)
	is_my_turn = true

func end_turn() -> void:
	print(self.name, " turns has ended")
	is_my_turn = false
	await execute_all_effect_for_time(self, Effect.EffectTime.OnTurnEnd)
	turn_ended.emit()

func take_damage(damage: int) -> void:
	current_health -= damage
	print(name, " took ", damage, " and left with current_health ", current_health)

func heal(amount: int) -> void:
	current_health += amount
	if (current_health > max_health):
		current_health = max_health
	print(name, " healed ", amount, " and now has current_health ", current_health)

func die() -> void:
	print(name, " is now dead")
	execute_all_effect_for_time(self, Effect.EffectTime.OnDeath)
	queue_free()

func give_status(status: AgentStatus) -> void:
	if statuses.has(status):
		print(name, " already has this status, ignoring")
		return
	if len(statuses) >= max_status_count:
		var status_to_remove = statuses.pop_front()
		print(name, " has too many statuses, removing last status")
		if status_to_remove.has_method("on_status_ended"):
			status_to_remove.on_status_ended(self)
	if status.has_method("on_status_given"):
		status.on_status_given(self)
	statuses.append(status)
	statuses_changed.emit(statuses)
	print(name, " now has ", len(statuses), " statuses")

#region Equipment Logic

func set_equipment(equipment: Dictionary) -> void:
	current_equipment = equipment
	for e: Equipment in current_equipment.values():
		if not e.prefab:
			printerr(e.name, " has no prefab")
		else:
			var equipment_instance = e.prefab.instantiate()
			match e.slot:
				Equipment.Slot.Head:
					_head_place_holder.add_child(equipment_instance)
				Equipment.Slot.RightHand:
					_right_hand_place_holder.add_child(equipment_instance)
				Equipment.Slot.LeftHand:
					_left_hand_place_holder.add_child(equipment_instance)
				Equipment.Slot.Boots:
					_legs_place_holder.add_child(equipment_instance)

func execute_all_effect_for_time(agent: Agent2D, effect_time: Effect.EffectTime):
	for i in current_equipment:
		var equipment : Equipment = current_equipment[i]
		for effect: Effect in equipment.effects:
			if effect.time == effect_time:
				await effect.execute(agent)

func get_total_health_bonus() -> int:
	var health_bonus = 0
	for i in current_equipment:
		health_bonus += current_equipment[i].bonus_health
	return health_bonus

func get_total_damage_bonus() -> int:
	var damage_bonus = 0
	for i in current_equipment:
		damage_bonus += current_equipment[i].bonus_damage
	return damage_bonus

#endregion

func _on_body_entered(body: Node) -> void:
	var collision_vfx
	if body is Agent2D:
		collision_vfx = collision_vfx_prefab.instantiate() as AgentCollisionEffect
	else:
		collision_vfx = wall_collision_vfx_prefab.instantiate() as AgentWallCollisionEffect
	collision_vfx.position = collision_pos
	get_tree().root.add_child(collision_vfx)
	if is_my_turn:
		execute_all_effect_for_time(self, Effect.EffectTime.OnCollision)
		if body is Agent2D:
			execute_all_effect_for_time(self, Effect.EffectTime.OnCollisionWithAgent)
	if !is_my_turn and body is Agent2D:
		var attacker = body as Agent2D
		take_damage(attacker.current_damage)

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	if state.get_contact_count() > 0:
		collision_pos = state.get_contact_local_position(0)

func _draw() -> void:
	if is_being_aimed:
		draw_arc(Vector2.ZERO, collision_shape.shape.radius, 0, 360, 64, Color.RED, 2)
