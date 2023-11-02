extends Agent

var pressed = false
var direction : Vector2
var velocity : float

@onready var line = $MovementPredictionLine

func _on_touch_screen_button_pressed():
	pressed = true

func _on_touch_screen_button_released():
	pressed = false
	move(direction, velocity)

func _input(event):
	if event is InputEventScreenDrag and pressed:
		var drag_position = event.get_position()
		direction = drag_position.direction_to(self.get_position())
		var distance = drag_position.distance_to(self.get_position())
		velocity = clamp(distance * velocity_multiplier, min_velocity, max_velocity)

func _process(delta):
	if pressed:
		line.update_trajectory(direction, velocity, delta)
		line.show()
	else:
		line.hide()
