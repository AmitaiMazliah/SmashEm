extends Resource

class_name VoidEventChannel

signal event_raised()

func raise_event() -> void:
	event_raised.emit()
