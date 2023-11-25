extends Control

class_name UnlockChestDialog

const START_UNLOCK_DURATION_TEXT = "[center][font_size=14]START UNLOCK[/font_size]
[img=20]res://art/timer-icon.png[/img] {duration}H
[/center]"
const OPEN_NOW_DURATION_PREFIX = "[font_size=14]UNLOCKING TAKES:[/font_size]
[img=20]res://art/timer-icon.png[/img]"

@onready var _chest_icon: TextureRect = $Panel/ChestIcon
@onready var _chest_name_label: Label = $Panel/ChestName

@onready var _start_unlock_button: Button = $Panel/StartUnlockButton
@onready var _start_unlock_button_text: RichTextLabel = $Panel/StartUnlockButton/RichTextLabel

@onready var _open_now_panel: Panel = $Panel/OpenNowPanel
@onready var _open_now_duration: RichTextLabel = $Panel/OpenNowPanel/UnlockDuration

var _player_chest: PlayerChest
var _can_start_unlock: bool

func set_chest(player_chest: PlayerChest, can_start_unlock: bool):
	_player_chest = player_chest
	_can_start_unlock = can_start_unlock

func _process(_delta):
	_update_ui()

func _update_ui():
	if (_player_chest != null):
		_chest_icon.texture = _player_chest.chest.icon
		_chest_name_label.text = _player_chest.chest.name
		if not _player_chest.started_open and _can_start_unlock:
			_open_now_panel.hide()
			_start_unlock_button.show()
			_start_unlock_button_text.text = START_UNLOCK_DURATION_TEXT.format({"duration": _player_chest.chest.duration_to_open_in_hours})
		else:
			_start_unlock_button.hide()
			_open_now_panel.show()
			_open_now_duration.text = OPEN_NOW_DURATION_PREFIX + _player_chest.get_remaining_time_as_string()
