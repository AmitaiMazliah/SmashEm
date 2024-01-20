extends Panel

class_name AgentDetailsPanel

const AGENT_HEALTH_TEXT = "[font_size=24][color=black]Hitpoints[/color]
{current_health}/{max_health}[/font_size]"
const AGENT_SPEED_TEXT = "[font_size=24][color=black]Speed[/color]
{speed}[/font_size]"
const AGENT_DAMAGE_TEXT = "[font_size=24][color=black]Damage[/color]
{damage}[/font_size]"

@onready var agent_health_label: RichTextLabel = $MarginContainer/Control/VBoxContainer/AgentStatsPanel/MarginContainer/VBoxContainer/AgentHealthPanel/HBoxContainer/AgentHealth
@onready var agent_speed_label: RichTextLabel = $MarginContainer/Control/VBoxContainer/AgentStatsPanel/MarginContainer/VBoxContainer/AgentSpeedPanel/HBoxContainer/AgentSpeed
@onready var agent_damage_label: RichTextLabel = $MarginContainer/Control/VBoxContainer/AgentStatsPanel/MarginContainer/VBoxContainer/AgentDamagePanel/HBoxContainer/AgentDamage
@onready var agent_head_item_icon: TextureRect = $MarginContainer/Control/VBoxContainer/AgentItemsContainer/HeadSlot/HeadItemIcon
@onready var default_agent_head_item_icon: TextureRect = $MarginContainer/Control/VBoxContainer/AgentItemsContainer/HeadSlot/DefaultHeadItemIcon
@onready var agent_right_hand_item_icon: TextureRect = $MarginContainer/Control/VBoxContainer/AgentItemsContainer/RightHandSlot/RightHandItemIcon
@onready var default_agent_right_hand_item_icon: TextureRect = $MarginContainer/Control/VBoxContainer/AgentItemsContainer/RightHandSlot/DefaultRightHandItemIcon
@onready var agent_left_hand_item_icon: TextureRect = $MarginContainer/Control/VBoxContainer/AgentItemsContainer/LeftHandSlot/LeftHandItemIcon
@onready var default_agent_left_hand_item_icon: TextureRect = $MarginContainer/Control/VBoxContainer/AgentItemsContainer/LeftHandSlot/DefaultLeftHandItemIcon
@onready var agent_boots_item_icon: TextureRect = $MarginContainer/Control/VBoxContainer/AgentItemsContainer/BootsSlot/BootsItemIcon
@onready var default_agent_boots_item_icon: TextureRect = $MarginContainer/Control/VBoxContainer/AgentItemsContainer/BootsSlot/DefaultBootsItemIcon
@onready var statuses_container: Control = $MarginContainer/Control/VBoxContainer/StatusesContainer

@export var status_details_prefab: PackedScene

var _agent: Agent2D

func _ready() -> void:
	hide()

func set_agent(agent: Agent2D):
	print("need to show details of ", agent.name)
	_agent = agent
	_set_agent_equipment_ui()
	agent.statuses_changed.connect(_on_agent_statuses_changed)
	_on_agent_statuses_changed(agent.statuses)
	show()

func close():
	_agent.statuses_changed.disconnect(_on_agent_statuses_changed)
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

func _on_agent_statuses_changed(statuses: Array[AgentStatus]) -> void:
	for child: Node in statuses_container.get_children():
		child.queue_free()
	for status: AgentStatus in statuses:
		var status_details = status_details_prefab.instantiate() as StatusDetailsUI
		status_details.ready.connect(func (): status_details.set_agent_status(status))
		statuses_container.add_child(status_details)

func _set_agent_equipment_ui() -> void:
	if _agent.current_equipment.has(Equipment.Slot.Head):
		default_agent_head_item_icon.hide()
		agent_head_item_icon.show()
		agent_head_item_icon.texture = _agent.current_equipment.get(Equipment.Slot.Head).icon
	else:
		default_agent_head_item_icon.show()
		agent_head_item_icon.hide()
	if _agent.current_equipment.has(Equipment.Slot.RightHand):
		default_agent_right_hand_item_icon.hide()
		agent_right_hand_item_icon.show()
		agent_right_hand_item_icon.texture = _agent.current_equipment.get(Equipment.Slot.RightHand).icon
	else:
		default_agent_right_hand_item_icon.show()
		agent_right_hand_item_icon.hide()
	if _agent.current_equipment.has(Equipment.Slot.LeftHand):
		default_agent_left_hand_item_icon.hide()
		agent_left_hand_item_icon.show()
		agent_left_hand_item_icon.texture = _agent.current_equipment.get(Equipment.Slot.LeftHand).icon
	else:
		default_agent_left_hand_item_icon.show()
		agent_left_hand_item_icon.hide()
	if _agent.current_equipment.has(Equipment.Slot.Boots):
		default_agent_boots_item_icon.hide()
		agent_boots_item_icon.show()
		agent_boots_item_icon.texture = _agent.current_equipment.get(Equipment.Slot.Boots).icon
	else:
		default_agent_boots_item_icon.show()
		agent_boots_item_icon.hide()
