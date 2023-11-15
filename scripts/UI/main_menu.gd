extends Node

@export var load_scene_event_channel: LoadSceneEventChannel
@export var game_scene: GameScene

func _on_play_button_pressed():
	load_scene_event_channel.raise_event(game_scene)
