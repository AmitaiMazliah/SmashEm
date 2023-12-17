extends Panel

class_name AgentDetailsPanel

const AGENT_HEALTH_TEXT = "[font_size=24][color=black]Hitpoints[/color]
{current_health}/{max_health}[/font_size]"
const AGENT_SPEED_TEXT = "[font_size=24][color=black]Speed[/color]
{speed}[/font_size]"
const AGENT_DAMAGE_TEXT = "[font_size=24][color=black]Damage[/color]
{damage}[/font_size]"

@onready var agent_health_label: RichTextLabel = $MarginContainer/Control/AgentStatsPanel/MarginContainer/VBoxContainer/AgentHealthPanel/HBoxContainer/AgentHealth
@onready var agent_speed_label: RichTextLabel = $MarginContainer/Control/AgentStatsPanel/MarginContainer/VBoxContainer/AgentSpeedPanel/HBoxContainer/AgentSpeed
@onready var agent_damage_label: RichTextLabel = $MarginContainer/Control/AgentStatsPanel/MarginContainer/VBoxContainer/AgentDamagePanel/HBoxContainer/AgentDamage
@onready var statuses_container: Control = $MarginContainer/Control/StatusesContainer

@export var status_details_prefab: PackedScene

var _agent: Agent2D

func _ready() -> void:
	hide()

func set_agent(agent: Agent2D):
	print("need to show details of ", agent.name)
	_agent = agent
	for status: AgentStatus in agent.statuses:
		var status_details = status_details_prefab.instantiate() as StatusDetailsUI
		status_details.ready.connect(func (): status_details.set_agent_status(status))
		statuses_container.add_child(status_details)
	show()

func close():
	for child: Node in statuses_container.get_children():
		child.queue_free()
	hide()

func _process(delta: float) -> void:
	if not visible:
		return
	
	agent_health_label.text = AGENT_HEALTH_TEXT.format({
		"current_health": _agent.current_health,
		"max_health": _agent.max_health
	})
	agent_speed_label.text = AGENT_SPEED_TEXT.format({
		"speed": _agent.current_velocity
	})
	agent_damage_label.text = AGENT_DAMAGE_TEXT.format({
		"damage": _agent.current_damage
	})
