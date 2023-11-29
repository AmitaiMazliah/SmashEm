extends Control

class_name UIPopup

var _toggle_blur_background_event: BoolEventChannel = load("res://resources/events/ui/toggle_blur_background_event.tres")
var _close_popup_event: VoidEventChannel = load("res://resources/events/ui/close_popup_event.tres")

func _ready():
	_close_popup_event.event_raised.connect(hide)

func open():
	_toggle_blur_background_event.raise_event(true)
	show()

func close():
	_toggle_blur_background_event.raise_event(false)
	hide()
