extends Node

class_name SceneLoader

@export var root : Node
@export var load_scene_event_chennl: SceneEventChannel
@export var load_main_menu_event_channel: VoidEventChannel
@export var main_menu_scene: PackedScene

var _current_scene: Node

func _ready():
	load_scene_event_chennl.event_raised.connect(_on_scene_requested)
	load_main_menu_event_channel.event_raised.connect(_on_scene_requested.bind(main_menu_scene))

func _on_scene_requested(packed_scene: PackedScene):
	if _current_scene:
		print("Removing scene ", _current_scene)
		root.remove_child(_current_scene)
	var scene = packed_scene.instantiate()
	print("Adding scene ", scene)
	_current_scene = scene
	root.add_child(scene)
