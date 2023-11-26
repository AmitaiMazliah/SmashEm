extends Resource

class_name FloatEventChannel

signal event_raised(value: float)

func raise_event(value : float) -> void:
	event_raised.emit(value)
