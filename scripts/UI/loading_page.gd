extends CanvasLayer

@onready var _progress_bar: ProgressBar = $ProgressBar

@export var toggle_loading_screen: BoolEventChannel

func _ready():
	toggle_loading_screen.event_raised.connect(_toggle_loading_screen)

func _toggle_loading_screen(state: bool):
	if state:
		show()
	else:
		hide()
