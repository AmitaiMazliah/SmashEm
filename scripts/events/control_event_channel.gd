extends Resource

class_name ControlEventChannel

signal event_raised(value: Control)

func raise_event(value : Control) -> void:
	event_raised.emit(value)
