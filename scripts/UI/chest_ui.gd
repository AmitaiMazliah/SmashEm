extends Control

class_name ChestUI

@onready var _icon: TextureRect = $ChestIcon
@onready var _duration_label: Label = $DurationLabel

var _chest: Chest

func set_chest(chest: Chest):
	_chest = chest
	if (chest != null):
		_icon.texture = chest.icon
		_duration_label.text = str(chest.duration_to_open_in_hours) + "h"
