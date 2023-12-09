extends Resource

class_name AgentStatus

@export var duration: int

var _agent: Agent3D
var _left_duration: int

func on_turn_ended():
	_left_duration -= 1
	if (_left_duration <= 0):
		on_status_ended(_agent)

func on_status_given(agent: Agent3D):
	_agent = agent
	_left_duration = duration

func on_status_ended(agent: Agent3D):
	print(agent.name, " slowed status ended")
