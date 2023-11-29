extends Control

@export var show_popup_event: ControlEventChannel

var _previous_popup: Control

func _ready():
	show_popup_event.event_raised.connect(_on_show_popup)

func _on_show_popup(popup: Control):
	_close_current_popup()
	if not popup:
		hide()
	else:
		var popup_duplicate = popup.duplicate() as Control
		add_child(popup_duplicate)
		popup_duplicate.show()
		_previous_popup = popup_duplicate
		show()

func _on_blur_background_pressed():
	_close_current_popup()
	hide()

func _close_current_popup():
	print()
	if _previous_popup:
		_previous_popup.queue_free()
		_previous_popup = null
