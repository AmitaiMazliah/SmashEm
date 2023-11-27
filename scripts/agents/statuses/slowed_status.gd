extends AgentStatus

class_name SlowedStatus

func on_status_given(agent: Agent):
	super.on_status_given(agent)
	print(agent.name, " slowed status given")

func on_status_ended(agent: Agent):
	print(agent.name, " slowed status ended")
