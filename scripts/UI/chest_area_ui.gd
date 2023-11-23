extends Control

class_name ChestArea

@onready var _chest_views: Array[Node] = $HBoxContainer.get_children()

@export var _chest_view_prefab: PackedScene

func set_chests(chests: Array[Chest]):
	for i in len(chests):
		var chest = chests[i]
		if chest:
			var chest_view = _chest_view_prefab.instantiate() as ChestUI
			chest_view.ready.connect(chest_view.set_chest.bind(chest))
			_chest_views[i].add_child(chest_view)
