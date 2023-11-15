extends Node

class_name SceneLoader

@export var root : Node
@export var load_scene_event_chennl: LoadSceneEventChannel
@export var play_music_event_channel: AudioCueEventChannel
@export var audio_config: AudioConfiguration
@export var load_main_menu_event_channel: VoidEventChannel
@export var main_menu_scene: GameScene

var _current_scene: Node
var _current_scene_music

func _ready():
	load_scene_event_chennl.event_raised.connect(_on_scene_requested)
	load_main_menu_event_channel.event_raised.connect(_on_scene_requested.bind(main_menu_scene))

func _on_scene_requested(scene_to_load: GameScene):
	_unload_previous_scene()
	_load_new_scene(scene_to_load)

func _unload_previous_scene():
	if _current_scene:
		print("Removing scene ", _current_scene)
		root.remove_child(_current_scene)

func _load_new_scene(scene_to_load: GameScene):
	var scene = scene_to_load.scene_reference.instantiate()
	print("Adding scene ", scene)
	scene.ready.connect(_on_new_scene_loaded.bind(scene_to_load))
	_current_scene = scene
	root.add_child(scene)

func _on_new_scene_loaded(scene_to_load: GameScene):
	if scene_to_load.music_track:
		play_music_event_channel.raise_play_event(scene_to_load.music_track, audio_config)
