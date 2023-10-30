extends RigidBody2D

class_name Agent

signal end_turn

@export_category("Movement")
@export var velocity_multiplier = 5
@export var min_velocity = 100
@export var max_velocity = 500

@export_category("Combat")
@export var max_health : int = 100

var current_health : int

var _my_turn : bool = false

func _ready():
	self.body_entered.connect(self._on_body_entered)
	current_health = max_health
	#_on_player_connected(1, {"name":"name"})

func _on_body_entered(body):
	print("_on_body_entered ", "self.name=", self.name, "body=", body)
	print(body.is_in_group("Agents"))
	if body.is_in_group("Agents"):
		body.take_damage(50)

func change_turn(is_my_turn: bool):
	_my_turn = is_my_turn

func move(direction: Vector2, velocity: float) -> void:
	if _my_turn:
		print("Moving in direction ", direction, " velocity ", velocity)
		apply_impulse(direction * velocity)

func take_damage(damage: int):
	current_health -= damage
	print("I'm ", self.name, " current_health ", current_health)
	if current_health <= 0:
		die()

func heal(amount: int):
	current_health += amount
	print("I'm ", self.name, " current_health ", current_health)

func die():
	print(self.name, " is now dead")
