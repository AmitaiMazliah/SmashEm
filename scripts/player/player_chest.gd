extends Resource

class_name PlayerChest

@export var chest: Chest
@export var started_open: bool
@export var open_start_time: float

var locked: bool :
	get:
		return remaining_open_time > 0

var remaining_open_time: int :
	get:
		var end_open_time = open_start_time + (chest.duration_to_open_in_hours * 3600)
		var r = end_open_time - Time.get_unix_time_from_system()
		return r
