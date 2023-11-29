extends Control

class_name ItemDetailsPopup

const ITEM_ATTACK_BONUS_TEXT = "[font_size=24][color=black]Damage[/color]
{damage}[/font_size]"
const ITEM_HEALTH_BONUS_TEXT = "[font_size=24][color=black]Hitpoints[/color]
{health}[/font_size]"
const ITEM_DESCRIPTION_TEXT = "[center][font_size=24]{description}[/font_size][/center]"

signal use_item(player_item: PlayerEquipment)

@onready var _item_name_label: Label = $Panel/MarginContainer/Control/ItemName
@onready var _item_icon: TextureRect = $Panel/MarginContainer/Control/ItemIconPanel/ItemIcon
@onready var _item_attack_bonus_label: RichTextLabel = $Panel/MarginContainer/Control/ItemStatsPanel/MarginContainer/VBoxContainer/DamageStatPanel/HBoxContainer/ItemDamageBonus
@onready var _item_health_bonus_label: RichTextLabel = $Panel/MarginContainer/Control/ItemStatsPanel/MarginContainer/VBoxContainer/HealthStatPanel/HBoxContainer/ItemHealthBonus
@onready var _item_description_label: RichTextLabel = $Panel/MarginContainer/Control/ItemDescriptionPanel/MarginContainer/ItemDescription

var _player_item: PlayerEquipment

func set_item(player_item: PlayerEquipment):
	_player_item = player_item
	_item_name_label.text = player_item.equipment.name
	_item_icon.texture = player_item.equipment.icon
	_item_attack_bonus_label.text = ITEM_ATTACK_BONUS_TEXT.format({ "damage": player_item.equipment.bonus_damage })
	_item_health_bonus_label.text = ITEM_HEALTH_BONUS_TEXT.format({ "health": player_item.equipment.bonus_health })
	_item_description_label.text = ITEM_DESCRIPTION_TEXT.format({ "description": player_item.equipment.description })
	show()

func _on_close_button_pressed():
	hide()

func _on_use_button_pressed():
	use_item.emit(_player_item)

func _on_blur_background_pressed():
	hide()
