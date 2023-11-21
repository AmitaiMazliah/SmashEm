extends Resource

class_name LoadSceneEventChannel

signal event_raised(value: GameScene, show_loading_screen: bool)

func raise_event(value : GameScene, show_loading_screen: bool) -> void:
	event_raised.emit(value, show_loading_screen)
