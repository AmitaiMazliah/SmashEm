extends Resource

class_name BoolEventChannel

signal event_raised(value: bool)

func raise_event(value : bool) -> void:
	event_raised.emit(value)
