extends Resource

class_name IntVariable

signal value_changed(value: int)

@export var value : int :
	set (new_value):
		value = new_value
		value_changed.emit(self.value)
	get:
		return value
