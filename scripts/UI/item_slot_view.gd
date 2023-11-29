extends Control

class_name ItemSlotView

signal selected

@onready var _item_icon: TextureRect = $VBoxContainer/Button/MarginContainer/ItemIcon
@onready var _item_process_bar: ProgressBar = $VBoxContainer/ProgressBar
@onready var _item_process_bar_label: Label = $VBoxContainer/ProgressBar/Label

var item: PlayerEquipment

func set_item(_item: PlayerEquipment):
	item = _item
	_update_ui()

func _update_ui():
	if item:
		_item_process_bar.show()
		_item_process_bar_label.show()
		_item_icon.texture = item.equipment.icon
		_item_process_bar.max_value = item.amount_to_upgrade
		_item_process_bar.value = item.amount
		_item_process_bar_label.text = str(item.amount) + "/" + str(item.amount_to_upgrade)
	else:
		_item_process_bar.hide()
		_item_process_bar_label.hide()

func _on_button_pressed():
	selected.emit()
