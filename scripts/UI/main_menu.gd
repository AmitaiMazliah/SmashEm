extends Node

@export var load_scene_event_channel: SceneEventChannel
@export var game_scene: PackedScene

func _on_play_button_pressed():
	print("press")
	load_scene_event_channel.raise_event(game_scene)
