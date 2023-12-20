extends AgentStatus

class_name PoisonStatus

@export var damage_per_turn: int
@export var turn_changed_event_channel: VoidEventChannel

func on_status_given(agent: Agent2D):
	super.on_status_given(agent)
	turn_changed_event_channel.event_raised.connect(_on_turn_changed)

func on_status_ended(agent: Agent2D):
	turn_changed_event_channel.event_raised.disconnect(_on_turn_changed)

func _on_turn_changed():
	_agent.take_damage(damage_per_turn)
