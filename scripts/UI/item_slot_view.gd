extends Control

class_name ItemSlotView

signal selected

@onready var _item_icon: TextureRect = $VBoxContainer/Button/MarginContainer/ItemIcon
@onready var _item_process_bar: ProgressBar = $VBoxContainer/ProgressBar
@onready var _item_process_bar_label: Label = $VBoxContainer/ProgressBar/Label
@onready var _options_container: VBoxContainer = $VBoxContainer/OptionsContainer
@onready var _upgrade_button: Button = $VBoxContainer/OptionsContainer/UpgradeButton
@onready var _info_button: Button = $VBoxContainer/OptionsContainer/InfoButton

var is_selected: bool = false :
	set (value):
		is_selected = value
		_on_selected_changed(value)
	get:
		return is_selected

var _item: PlayerEquipment

func _ready():
	_options_container.hide()

func set_item(item: PlayerEquipment):
	_item = item
	_update_ui()

func _on_selected_changed(is_selected: bool):
	if not _item:
		return
	
	if is_selected:
		_options_container.show()
	else:
		_options_container.hide()

func _update_ui():
	if _item:
		_item_process_bar.show()
		_item_process_bar_label.show()
		_item_icon.texture = _item.equipment.sprite
		_item_process_bar.max_value = _item.amount_to_upgrade
		_item_process_bar.value = _item.amount
		_item_process_bar_label.text = str(_item.amount) + "/" + str(_item.amount_to_upgrade)
		if _item.can_upgrade():
			_upgrade_button.show()
			_info_button.hide()
		else:
			_upgrade_button.hide()
			_info_button.show()
	else:
		_item_process_bar.hide()
		_item_process_bar_label.hide()


func _on_button_pressed():
	selected.emit()
