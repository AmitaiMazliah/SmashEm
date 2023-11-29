extends Control

class_name UIPopup

var show_popup_event: ControlEventChannel = load("res://resources/events/ui/show_popup_event.tres")

func _ready():
	hide()

func open():
	show_popup_event.raise_event(self)

func close():
	show_popup_event.raise_event(null)
