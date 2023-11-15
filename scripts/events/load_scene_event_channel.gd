extends Resource

class_name LoadSceneEventChannel

signal event_raised(value: GameScene)

func raise_event(value : GameScene) -> void:
	event_raised.emit(value)
