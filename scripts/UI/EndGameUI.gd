extends CanvasLayer

@onready var label: Label = $CenterContainer/Label

@export var victory_event_channel: VoidEventChannel
@export var defeat_event_channel: VoidEventChannel

func _ready():
	victory_event_channel.event_raised.connect(_on_victory)
	defeat_event_channel.event_raised.connect(_on_defeat)

func _on_victory():
	label.text = "Vicotory!!!"

func _on_defeat():
	label.text = "Defeat!!!"
