extends Node

class_name SceneLoader

@export var root : Node
@export var load_scene_event_chennl: SceneEventChannel

var _current_scene: Node

func _ready():
	load_scene_event_chennl.event_raised.connect(_on_scene_requested)

func _on_scene_requested(packed_scene: PackedScene):
	if _current_scene:
		root.remove_child(_current_scene)
	var scene = packed_scene.instantiate()
	_current_scene = scene
	root.add_child(scene)
