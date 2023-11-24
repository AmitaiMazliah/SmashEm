extends Control

class_name UnlockChestDialog

@onready var _chest_icon: TextureRect = $Panel/ChestIcon
@onready var _chest_name_label: Label = $Panel/ChestName

@onready var _start_unlock_button: Button = $Panel/StartUnlockButton
@onready var _open_now_panel: Panel = $Panel/OpenNowPanel

var _player_chest: PlayerChest

func set_chest(player_chest: PlayerChest):
	_player_chest = player_chest

func _process(_delta):
	_update_ui()

func _update_ui():
	if (_player_chest != null):
		_chest_icon.texture = _player_chest.chest.icon
		_chest_name_label.text = _player_chest.chest.name
		if not _player_chest.started_open:
			_open_now_panel.hide()
			_start_unlock_button.show()
		elif _player_chest.locked:
			_start_unlock_button.hide()
			_open_now_panel.show()
#			var remaining_time = _player_chest.remaining_open_time
#			var time_dict = Time.get_time_dict_from_unix_time(remaining_time)
#			var hours = time_dict.get("hour")
#			var minutes = time_dict.get("minute")
#			var seconds = time_dict.get("second")
#			if hours > 0:
#				_opening_panel_duration_label.text = str(hours) + "h " + str(minutes) + "min"
#			elif minutes > 0:
#				_opening_panel_duration_label.text = str(minutes) + "min " + str(seconds) + "secs"
#			else:
#				_opening_panel_duration_label.text = str(seconds) + "secs"
		else:
			print("")
