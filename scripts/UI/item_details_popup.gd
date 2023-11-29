extends UIPopup

class_name ItemDetailsPopup

@onready var _item_name_label: Label = $Panel/MarginContainer/Control/ItemName
@onready var _item_icon: TextureRect = $Panel/MarginContainer/Control/Panel/ItemIcon

func set_item(player_item: PlayerEquipment):
	_item_name_label.text = player_item.equipment.name
	_item_icon.texture = player_item.equipment.icon
	open()

func _on_close_button_pressed():
	close()
