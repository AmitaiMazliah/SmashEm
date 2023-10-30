extends Resource

class_name IntEventChannel

signal event_raised(value: int)

func raise_event(value : int) -> void:
	event_raised.emit(value)
