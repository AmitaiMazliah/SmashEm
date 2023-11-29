extends Button

class_name ShopItemView

@onready var _item_icon: TextureRect = $MarginContainer/VBoxContainer/ItemIcon
@onready var _item_name_label: Label = $MarginContainer/VBoxContainer/ItemName

var _item: Equipment

func set_item(item: Equipment):
	_item = item
	_update_ui()

func _update_ui():
	_item_icon.texture = _item.icon
	_item_name_label.text = _item.name
	tooltip_text = _item.description
