extends Button

@export var _close_popup_event: VoidEventChannel
@export var _toggle_blur_background_event: BoolEventChannel

func _ready():
	_toggle_blur_background_event.event_raised.connect(_on_toggle_blur_background)

func _on_toggle_blur_background(show: bool):
	if show:
		show()
	else:
		hide()

func _pressed():
	_close_popup_event.raise_event()
	hide()
