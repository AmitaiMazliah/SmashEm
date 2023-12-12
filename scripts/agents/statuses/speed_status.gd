extends AgentStatus

class_name SpeedStatus

@export_range(-1, 1, 0.01) var change_percentage: float

var _previous_velocity

func on_status_given(agent: Agent2D):
	super.on_status_given(agent)
	_previous_velocity = agent.current_velocity
	agent.current_velocity = agent.current_velocity * (1 + change_percentage)

func on_status_ended(agent: Agent2D):
	agent.current_velocity = _previous_velocity
