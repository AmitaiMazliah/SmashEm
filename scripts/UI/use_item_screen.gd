extends CanvasLayer

class_name UseItemScreen

@onready var _draggable_item_view: DraggableItemView = $ItemContainer/DraggableItemView

func set_item(player_item: PlayerEquipment):
	_draggable_item_view.set_item(player_item)
	show()
