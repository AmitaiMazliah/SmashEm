extends Node

class_name HealthComponent

@export var log_events : bool = true
@export var default_health : int = 100

var max_health : int
var current_health : int

@onready var agent : Agent = get_parent()

signal death()

func _ready():
	max_health = default_health
	max_health = default_health + agent.get_node("AgentEquipment").get_total_health_bonus()
	current_health = max_health

func take_damage(damage: int):
	current_health -= damage
	if log_events:
		print(agent.name, " took ", damage, " and left with current_health ", current_health)
	if current_health <= 0:
		die()

func heal(amount: int):
	current_health += amount
	if (current_health > max_health):
		current_health = max_health
	if log_events:
		print(agent.name, " healed ", amount, " and now has current_health ", current_health)

func die():
	if log_events:
		print(agent.name, " is now dead")
	death.emit()