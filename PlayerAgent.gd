extends RigidBody2D

@export var velocity_multiplier = 5
@export var min_velocity = 100
@export var max_velocity = 500

var pressed = false
var direction : Vector2
var velocity : float

var line

func _ready():
	line = get_node("MovementPredictionLine")

func _on_touch_screen_button_pressed():
	pressed = true

func _on_touch_screen_button_released():
	pressed = false
	print("direction ", direction)
	print("velocity ", velocity)
	apply_impulse(direction * velocity)

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
