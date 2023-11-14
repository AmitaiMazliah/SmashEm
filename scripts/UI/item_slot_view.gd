extends PanelContainer

class_name ItemSlotView

@onready var _item_icon: TextureRect = $MarginContainer/VBoxContainer/ItemIcon

var _item: Equipment

func _ready():
	_update_ui()

func set_item(item: Equipment):
	_item = item
	_update_ui()

func _update_ui():
	if not _item:
		return
	if _item_icon:
		_item_icon.texture = _item.sprite
	tooltip_text = _item.description
