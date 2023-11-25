extends Panel

class_name ChestUI

@onready var button: Button = $Button
@onready var _icon: TextureRect = $ChestIcon

@onready var _locked_panel: Control = $LockedPanel
@onready var _locked_panel_duration_label: Label = $LockedPanel/DurationLabel

@onready var _opening_panel: Control = $OpeningPanel
@onready var _opening_panel_duration_label: Label = $OpeningPanel/DurationPanel/Duration

@onready var _opened_panel: Control = $OpenedPanel

var _player_chest: PlayerChest

func set_chest(player_chest: PlayerChest):
	_player_chest = player_chest

func _process(_delta):
	_update_ui()

func _update_ui():
	if (_player_chest != null):
		_icon.texture = _player_chest.chest.icon
		if not _player_chest.started_open:
			button.flat = true
			_opening_panel.hide()
			_opened_panel.hide()
			_locked_panel.show()
			_locked_panel_duration_label.text = str(_player_chest.chest.duration_to_open_in_hours) + "h"
		elif _player_chest.locked:
			button.flat = true
			_locked_panel.hide()
			_opened_panel.hide()
			_opening_panel.show()
			_opening_panel_duration_label.text = _player_chest.get_remaining_time_as_string()
		else:
			button.flat = false
			_locked_panel.hide()
			_opening_panel.hide()
			_opened_panel.show()
	else:
		queue_free()
