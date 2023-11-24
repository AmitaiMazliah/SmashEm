extends Control

class_name ChestArea

@onready var _chest_views: Array[Node] = $HBoxContainer.get_children()

@export var _chest_view_prefab: PackedScene

signal chest_selected(chest: PlayerChest)

func set_chests(chests: Array[PlayerChest]):
	for i in len(chests):
		var player_chest = chests[i]
		if player_chest:
			_chest_views[i].get_child(0).hide()
			var chest_view = _chest_view_prefab.instantiate() as ChestUI
			chest_view.ready.connect(func ():
				chest_view.set_chest(player_chest)
				chest_view.button.pressed.connect(self._on_chest_selected.bind(player_chest))
			)
			_chest_views[i].add_child(chest_view)
		else:
			_chest_views[i].get_child(0).show()

func _on_chest_selected(chest: PlayerChest):
	chest_selected.emit(chest)
