extends RigidBody2D

class_name Agent

signal turn_ended
signal moved

var dead : bool = false

@export var nodes_to_disable_on_death : Array[Node]

@export_category("Movement")
@export var default_velocity : float = 500

@export_category("Combat")
@export var health : HealthComponent
@export var default_damage : int = 5

@onready var _equipment : AgentEquipment = $AgentEquipment

var _my_turn : bool = false
var _current_damage : int
var _moving : bool = false

func _ready():
	body_entered.connect(_on_body_entered)
	health.death.connect(_on_death)
	_current_damage = default_damage + _equipment.get_total_damage_bonus()

func _on_body_entered(body):
	if _my_turn and body is Agent:
		var agent = body as Agent
		print(self.name, " is attacking ", agent.name)
		agent.health.take_damage(_current_damage)

func change_turn(is_my_turn: bool):
	if (_my_turn and !is_my_turn):
		_on_end_turn()
	elif (!_my_turn and is_my_turn):
		_on_start_turn()
	_my_turn = is_my_turn

func move(direction: Vector2) -> void:
	if _my_turn:
		print("Moving in direction ", direction)
		apply_impulse(direction * default_velocity)
		moved.emit()

func kill():
	_equipment.execute_all_effect_for_time(self, Effect.EffectTime.OnDeath)
	for node in nodes_to_disable_on_death:
		remove_child(node)

func end_turn():
	_my_turn = false
	turn_ended.emit()
	
func _on_start_turn():
	print(self.name, " turns has started")
	_equipment.execute_all_effect_for_time(self, Effect.EffectTime.OnTurnStart)

func _on_end_turn():
	print(self.name, " turns has ended")
	_equipment.execute_all_effect_for_time(self, Effect.EffectTime.OnTurnEnd)

func _on_death():
	dead = true
