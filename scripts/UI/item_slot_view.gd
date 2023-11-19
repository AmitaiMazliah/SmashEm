extends Button

class_name ItemSlotView

@onready var _item_icon: TextureRect = $MarginContainer/ItemIcon
@onready var _options_container: VBoxContainer = $OptionsContainer
@onready var _upgrade_button: Button = $OptionsContainer/UpgradeButton
@onready var _info_button: Button = $OptionsContainer/InfoButton

var selected: bool = false :
	set (value):
		selected = value
		_on_selected_changed(value)
	get:
		return selected

var _item: PlayerEquipment

func _ready():
	_options_container.hide()
#	_update_ui()

func set_item(item: PlayerEquipment):
	_item = item
	_update_ui()

func _on_selected_changed(selected: bool):
	if selected:
		_options_container.show()
	else:
		_options_container.hide()

func _update_ui():
	if _item:
		if _item.can_upgrade():
			_upgrade_button.show()
			_info_button.hide()
		else:
			_upgrade_button.hide()
			_info_button.show()
		_item_icon.texture = _item.equipment.sprite
		tooltip_text = _item.equipment.description
