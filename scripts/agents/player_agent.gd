extends Agent

@export var distance_from_touch_location_to_count_play : float = 60
var pressed = false
var direction : Vector2

@onready var line = $MovementPredictionLine

var _distance_from_press_location : float
var _played : bool = false

func _on_touch_screen_button_pressed():
	pressed = true

func _on_touch_screen_button_released():
	pressed = false
	if _distance_from_press_location > distance_from_touch_location_to_count_play:
		_played = true
		move(direction)

func _input(event):
	if event is InputEventScreenDrag and pressed:
		var drag_position = event.get_position()
		direction = drag_position.direction_to(self.get_position())
		_distance_from_press_location = drag_position.distance_to(self.get_position())

func _process(delta):
	if pressed and _distance_from_press_location > distance_from_touch_location_to_count_play:
		line.update_trajectory(direction, default_velocity, delta)
		line.show()
	else:
		line.hide()

func _on_sleeping_state_changed():
	if _my_turn and sleeping and _played:
		print(self.name, " went sleeping, ending turn")
		end_turn()
		_played = false
