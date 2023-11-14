extends Resource

class_name SaveSystem

@export var file_name: String = "player"

var _file_location = "user://" + file_name + ".json"

var _values: Dictionary
var _dirty_values: Dictionary

func get_value(key: String, default_value = null):
	var value
	if _dirty_values.has(key):
		return _dirty_values.get(key)
	else:
		return _values.get(key, default_value)

func set_value(key: String, value, save_immediately: bool = true):
	_dirty_values[key] = value
	if save_immediately:
		save()

func discard_changes():
	_dirty_values.clear()

func save() -> void:
	if _dirty_values.size() == 0:
		return
	_save_to_disk()
	_values.merge(_dirty_values, true)
	_dirty_values.clear()

func load():
	var file := FileAccess.open(_file_location, FileAccess.READ)
	var json := JSON.new()
	json.parse(file.get_line())
	_values = json.get_data() as Dictionary

func _save_to_disk():
	var file := FileAccess.open(_file_location, FileAccess.WRITE)

	file.store_line(JSON.stringify(_dirty_values))
