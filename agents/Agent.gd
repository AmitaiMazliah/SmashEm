extends RigidBody2D

class_name Agent

signal end_turn

@export_category("Movement")
@export var velocity_multiplier = 5
@export var min_velocity = 100
@export var max_velocity = 500

@export_category("Combat")
@export var default_health : int = 100
@export var default_damage : int = 5

var max_health : int
var current_health : int

@onready var _equipment : AgentEquipment = $AgentEquipment

var _my_turn : bool = false
var _current_damage : int

func _ready():
	self.body_entered.connect(self._on_body_entered)
	max_health = default_health + _equipment.get_total_health_bonus()
	current_health = max_health
	_current_damage = default_damage + _equipment.get_total_damage_bonus()

func _on_body_entered(body):
	print("_on_body_entered ", "self.name=", self.name, "body=", body)
	print(body.is_in_group("Agents"))
	if body.is_in_group("Agents"):
		body.take_damage(_current_damage)

func change_turn(is_my_turn: bool):
	if (_my_turn and !is_my_turn):
		_on_end_turn()
	elif (!_my_turn and is_my_turn):
		_on_start_turn()
	_my_turn = is_my_turn

func move(direction: Vector2, velocity: float) -> void:
	if _my_turn:
		print("Moving in direction ", direction, " velocity ", velocity)
		apply_impulse(direction * velocity)

func take_damage(damage: int):
	current_health -= damage
	print(self.name, " took ", damage, " and left with current_health ", current_health)
	if current_health <= 0:
		die()

func heal(amount: int):
	current_health += amount
	if (current_health > max_health):
		current_health = max_health
	print(self.name, " healed ", amount, " and now has current_health ", current_health)

func die():
	print(self.name, " is now dead")

func _on_start_turn():
	print(self.name, " turns has started")
	_equipment.execute_all_effect_for_time(self, Constants.EffectTime.OnTurnStart)

func _on_end_turn():
	print(self.name, " turns has ended")
	_equipment.execute_all_effect_for_time(self, Constants.EffectTime.OnTurnEnd)
