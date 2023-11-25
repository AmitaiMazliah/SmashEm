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
		if not started_open:
			return chest.duration_to_open_in_hours * 3600
		var end_open_time = open_start_time + (chest.duration_to_open_in_hours * 3600)
		var r = end_open_time - Time.get_unix_time_from_system()
		return r

func get_remaining_time_as_string() -> String:
	var remaining_time = remaining_open_time
	var time_dict = Time.get_time_dict_from_unix_time(remaining_time)
	var hours = time_dict.get("hour")
	var minutes = time_dict.get("minute")
	var seconds = time_dict.get("second")
	if hours > 0:
		return str(hours) + "h " + str(minutes) + "min"
	elif minutes > 0:
		return str(minutes) + "min " + str(seconds) + "secs"
	else:
		return str(seconds) + "secs"
