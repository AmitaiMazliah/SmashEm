extends CanvasLayer

@onready var match_end_pabel: Panel = $MatchEndPanel
@onready var label: Label = $MatchEndPanel/Label

@export var victory_event_channel: VoidEventChannel
@export var defeat_event_channel: VoidEventChannel
@export var load_scene_event_chennl: SceneEventChannel
@export var main_menu_scene: PackedScene

func _ready():
	victory_event_channel.event_raised.connect(_on_victory)
	defeat_event_channel.event_raised.connect(_on_defeat)
	match_end_pabel.hide()

func _on_victory():
	label.text = "Vicotory!!!"
	match_end_pabel.show()

func _on_defeat():
	label.text = "Defeat!!!"
	match_end_pabel.show()

func _on_back_button_pressed():
	load_scene_event_chennl.raise_event(main_menu_scene)
