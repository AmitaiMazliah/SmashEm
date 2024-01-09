extends AgentStatus

class_name PoisonStatus

@export var damage_per_turn: int

func on_turn_changed():
	_agent.take_damage(damage_per_turn)
