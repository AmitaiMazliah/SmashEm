extends Control

class_name DraggableItemView

@export var _item_icon: TextureRect
#@onready var _item_process_bar: ProgressBar = $VBoxContainer/ProgressBar
#@onready var _item_process_bar_label: Label = $VBoxContainer/ProgressBar/Label

var item: PlayerEquipment

func set_item(_item: PlayerEquipment):
	item = _item
	_update_ui()

func _update_ui():
	if item:
		_item_icon.texture = item.equipment.icon

func _get_drag_data(at_position):
	var preview = duplicate() as DraggableItemView
	preview.set_item(item)
	preview.size = size
	
	var c = Control.new()
	c.add_child(preview)
	preview.position = -0.5 * preview.size
	set_drag_preview(c)
	
	return item
