extends CanvasLayer

@onready var match_end_pabel: Panel = $MatchEndPanel
@onready var label: Label = $MatchEndPanel/Label
@onready var agents_container: Control = $ButtomPanel/MarginContainer/AgentsContainer
@onready var agent_details_panel: AgentDetailsPanel = $AgentDetailsPanel

@export var victory_event_channel: VoidEventChannel
@export var defeat_event_channel: VoidEventChannel
@export var load_main_menu_event_channel: VoidEventChannel
@export var agent_panel_prefab: PackedScene

func _ready():
	victory_event_channel.event_raised.connect(_on_victory)
	defeat_event_channel.event_raised.connect(_on_defeat)
	match_end_pabel.hide()
	var agents = get_tree().get_nodes_in_group("Agents")
	for agent: Agent2D in agents:
		var agent_panel = agent_panel_prefab.instantiate() as AgentPanel
		agent_panel.set_agent(agent)
		agent_panel.pressed.connect(func (): agent_details_panel.set_agent(agent))
		agent_panel.released.connect(func (): agent_details_panel.close())
		agents_container.add_child(agent_panel)
		agent.died.connect(_on_agent_died.bind(agent_panel))

func _on_victory():
	label.text = "Vicotory!!!"
	match_end_pabel.show()

func _on_defeat():
	label.text = "Defeat!!!"
	match_end_pabel.show()

func _on_back_button_pressed():
	load_main_menu_event_channel.raise_event()

func _on_agent_died(agent_panel: AgentPanel):
	agent_panel.disabled = true
	#agents_container.remove_child(agent_panel)
	#agent_panel.queue_free()
