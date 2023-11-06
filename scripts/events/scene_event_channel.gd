extends Resource

class_name SceneEventChannel

signal event_raised(value: PackedScene)

func raise_event(value : PackedScene) -> void:
	event_raised.emit(value)
