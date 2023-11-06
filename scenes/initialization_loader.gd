extends Node

@export var load_scene_event_channel: SceneEventChannel
@export var main_menu_scene: PackedScene

func _ready():
	load_scene_event_channel.raise_event(main_menu_scene)
