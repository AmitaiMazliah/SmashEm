extends Resource

class_name AgentStatus

@export var name: String
@export_multiline var description: String
@export var icon: Texture

var _agent: Agent2D

func on_status_given(agent: Agent2D):
	_agent = agent

func on_status_ended(agent: Agent2D):
	pass
