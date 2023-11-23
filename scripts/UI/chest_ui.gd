extends Panel

class_name ChestUI

@onready var _button: Button = $Button
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
			_button.flat = true
			_opening_panel.hide()
			_opened_panel.hide()
			_locked_panel.show()
			_locked_panel_duration_label.text = str(_player_chest.chest.duration_to_open_in_hours) + "h"
		elif _player_chest.locked:
			_button.flat = true
			_locked_panel.hide()
			_opened_panel.hide()
			_opening_panel.show()
			var remaining_time = _player_chest.remaining_open_time
			var time_dict = Time.get_time_dict_from_unix_time(remaining_time)
			var hours = time_dict.get("hour")
			var minutes = time_dict.get("minute")
			var seconds = time_dict.get("second")
			if hours > 0:
				_opening_panel_duration_label.text = str(hours) + "h " + str(minutes) + "min"
			elif minutes > 0:
				_opening_panel_duration_label.text = str(minutes) + "min " + str(seconds) + "secs"
			else:
				_opening_panel_duration_label.text = str(seconds) + "secs"
		else:
			_button.flat = false
			_locked_panel.hide()
			_opening_panel.hide()
			_opened_panel.show()
	else:
		queue_free()
