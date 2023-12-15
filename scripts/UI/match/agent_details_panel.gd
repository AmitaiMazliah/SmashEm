extends Panel

class_name AgentDetailsPanel

@onready var statuses_container: Control = $MarginContainer/Control/StatusesContainer

@export var status_details_prefab: PackedScene

func _ready() -> void:
	hide()

func set_agent(agent: Agent2D):
	print("need to show details of ", agent.name)
	for status: AgentStatus in agent.statuses:
		var status_details = status_details_prefab.instantiate() as StatusDetailsUI
		status_details.ready.connect(func (): status_details.set_agent_status(status))
		statuses_container.add_child(status_details)
	show()

func close():
	for child: Node in statuses_container.get_children():
		child.queue_free()
	hide()
