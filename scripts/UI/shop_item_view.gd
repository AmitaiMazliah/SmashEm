extends Button

class_name ShopItemView

@onready var _item_icon: TextureRect = $MarginContainer/VBoxContainer/ItemIcon
@onready var _item_name_label: Label = $MarginContainer/VBoxContainer/ItemName

var _item: Equipment

func _ready():
	_update_ui()

func set_item(item: Equipment):
	_item = item
	_update_ui()

func _update_ui():
	if _item_icon:
		_item_icon.texture = _item.sprite
	if _item_name_label:
		_item_name_label.text = _item.name
	tooltip_text = _item.description
