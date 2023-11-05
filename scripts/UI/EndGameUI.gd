extends CanvasLayer

@onready var label: Label = $CenterContainer/Label

@export var victory_event_channel: VoidEventChannel

func _ready():
	victory_event_channel.event_raised.connect(_on_victory)

func _on_victory():
	label.text = "Vicotory!!!"
