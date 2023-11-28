extends AgentStatus

class_name SlowedStatus

var _previous_velocity

func on_status_given(agent: Agent):
	super.on_status_given(agent)
	print(agent.name, " slowed status given")
	_previous_velocity = agent.current_velocity
	agent.current_velocity = agent.current_velocity * 0.01

func on_status_ended(agent: Agent):
	print(agent.name, " slowed status ended")
	agent.current_velocity = _previous_velocity
