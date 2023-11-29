extends CanvasLayer

class_name UseItemScreen

@onready var _draggable_item_view: DraggableItemView = $ItemContainer/DraggableItemView

func _ready():
	Player.selected_items_changed.connect(hide)

func set_item(player_item: PlayerEquipment):
	_draggable_item_view.set_item(player_item)
	show()

func _on_blur_background_pressed():
	hide()
