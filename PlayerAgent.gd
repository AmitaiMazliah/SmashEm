extends RigidBody2D

@export var velocity_multiplier = 5
@export var min_velocity = 100
@export var max_velocity = 500

var pressed = false
var drag_position : Vector2

func _on_touch_screen_button_pressed():
	pressed = true

func _on_touch_screen_button_released():
	pressed = false
	var direction = drag_position.direction_to(self.get_position())
	var distance = drag_position.distance_to(self.get_position())
	print("direction ", direction)
	print("distance ", distance)
	var velocity = clamp(distance, min_velocity, max_velocity)
	print("velocity ", velocity)
	apply_impulse(direction * (velocity * velocity_multiplier))

func _input(event):
	if event is InputEventScreenDrag and pressed:
		drag_position = event.get_position()
