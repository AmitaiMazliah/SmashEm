extends Control

class_name StatusDetailsUI

@onready var status_name_label: Label = $ItemStatsPanel/MarginContainer/Control/StatusNameLabel
@onready var status_description_label: Label = $ItemStatsPanel/MarginContainer/Control/StatusDescriptionLabel

func set_agent_status(agent_status: AgentStatus):
	status_name_label.text = agent_status.name
	status_description_label.text = agent_status.description
