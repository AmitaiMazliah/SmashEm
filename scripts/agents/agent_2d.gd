extends RigidBody2D

class_name Agent2D

signal moved
signal turn_ended

@export var starting_velocity: float = 5
@export var starting_health: int = 100
@export var starting_damage: int = 5

var is_my_turn: bool
var moving: bool
var current_velocity: float
var max_health: int
var current_health: int
var current_damage: int
var previous_velocity: Vector2
var is_player: bool

func _ready():
	body_entered.connect(_on_body_entered)
	current_velocity = starting_velocity
	max_health = starting_health
	current_health = max_health
	current_damage = starting_damage

func _physics_process(_delta):
	if linear_velocity.length_squared() > 0.01:
		moving = true
	elif linear_velocity.length_squared() < 0.01:
		moving = false
	previous_velocity = linear_velocity

func move(direction: Vector2):
	if is_my_turn:
		print(name, " is moving in direction=", direction, " speed=", current_velocity)
		apply_impulse(direction * current_velocity)
		moved.emit()

func start_turn():
	print(self.name, " turns has started")
	is_my_turn = true

func end_turn():
	print(self.name, " turns has ended")
	is_my_turn = false
	turn_ended.emit()

func take_damage(damage: int):
	current_health -= damage
	print(name, " took ", damage, " and left with current_health ", current_health)

func heal(amount: int):
	current_health += amount
	if (current_health > max_health):
		current_health = max_health
	print(name, " healed ", amount, " and now has current_health ", current_health)

func die():
	print(name, " is now dead")
	queue_free()

func _on_body_entered(body: Node):
	if !is_my_turn and body is Agent2D:
		var attacker = body as Agent2D
		take_damage(attacker.current_damage)
#
#
#signal turn_ended
#signal moved
#
#var dead : bool = false
#
#@export var nodes_to_disable_on_death : Array[Node]
#
#@export_category("Movement")
#@export var default_velocity : float = 500
#
#@export_category("Combat")
#@export var health : HealthComponent
#@export var default_damage : int = 5
#
#@onready var _equipment : AgentEquipment = $AgentEquipment
#
#var current_velocity: float
#var _my_turn : bool = false
#var _current_damage : int
#var status: AgentStatus :
	#set(value):
		#var previous_status = status
		#if previous_status and previous_status.has_method("on_status_ended"):
			#previous_status.on_status_ended(self)
		#status = value
		#if status and status.has_method("on_status_given"):
			#status.on_status_given(self)
	#get:
		#return status
#
#func _ready():
	#body_entered.connect(_on_body_entered)
	#health.death.connect(_on_death)
	#_current_damage = default_damage + _equipment.get_total_damage_bonus()
	#current_velocity = default_velocity
#
#func _on_body_entered(body):
	#_equipment.execute_all_effect_for_time(self, Effect.EffectTime.OnCollision)
	#if _my_turn and body is Agent:
		#var agent = body as Agent
		#print(self.name, " is attacking ", agent.name)
		#agent.health.take_damage(_current_damage)
#
#func change_turn(is_my_turn: bool):
	#if (_my_turn and !is_my_turn):
		#_on_end_turn()
	#elif (!_my_turn and is_my_turn):
		#_on_start_turn()
	#_my_turn = is_my_turn
#
#func move(direction: Vector2) -> void:
	#if _my_turn:
		#print("Moving in direction ", direction, " velocity ", current_velocity)
		#apply_impulse(direction * current_velocity)
		#moved.emit()
#
#func kill():
	#_equipment.execute_all_effect_for_time(self, Effect.EffectTime.OnDeath)
	#for node in nodes_to_disable_on_death:
		#remove_child(node)
#
#func end_turn():
	#turn_ended.emit()
#
#func _on_start_turn():
	#print(self.name, " turns has started")
	#_equipment.execute_all_effect_for_time(self, Effect.EffectTime.OnTurnStart)
#
#func _on_end_turn():
	#print(self.name, " turns has ended")
	#if status:
		#status.on_turn_ended()
	#for i in _equipment.current_equipment:
		#var equipment : Equipment = _equipment.current_equipment[i]
		#if equipment.has_method("on_turn_end"):
			#equipment.on_turn_end()
	#_equipment.execute_all_effect_for_time(self, Effect.EffectTime.OnTurnEnd)
	#_my_turn = false
#
#func _on_death():
	#dead = true
