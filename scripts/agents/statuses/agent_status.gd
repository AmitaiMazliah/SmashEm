extends Resource

class_name AgentStatus

@export var duration: int

var _agent: Agent2D
var _left_duration: int

func on_turn_ended():
	_left_duration -= 1
	if (_left_duration <= 0):
		on_status_ended(_agent)

func on_status_given(agent: Agent2D):
	_agent = agent
	_left_duration = duration

func on_status_ended(agent: Agent2D):
	print(agent.name, " slowed status ended")
