extends Control

class_name StatusDetailsUI

@onready var status_icon: TextureRect = $StatusIcon

func set_agent_status(agent_status: AgentStatus):
	status_icon.texture = agent_status.icon
