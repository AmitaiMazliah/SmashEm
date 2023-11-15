extends Node

@export var load_scene_event_channel: LoadSceneEventChannel
@export var main_menu_scene: GameScene

func _ready():
	load_scene_event_channel.raise_event(main_menu_scene)
