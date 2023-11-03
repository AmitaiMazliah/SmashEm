extends Agent

var pressed = false
var direction : Vector2

@onready var line = $MovementPredictionLine

var _distance_from_press_location : float

func _on_touch_screen_button_pressed():
	pressed = true

func _on_touch_screen_button_released():
	pressed = false
	if _distance_from_press_location > 60:
		move(direction)

func _input(event):
	if event is InputEventScreenDrag and pressed:
		var drag_position = event.get_position()
		direction = drag_position.direction_to(self.get_position())
		_distance_from_press_location = drag_position.distance_to(self.get_position())
		print("distance=", _distance_from_press_location)

func _process(delta):
	if pressed and _distance_from_press_location > 60:
		line.update_trajectory(direction, default_velocity, delta)
		line.show()
	else:
		line.hide()
