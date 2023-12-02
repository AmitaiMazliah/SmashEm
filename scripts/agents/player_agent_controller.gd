extends Node

@export var distance_from_touch_location_to_count_play : float = 60

@onready var agent: MyAgent = self.get_parent()
@onready var agent_movement_projection: AgentMovementProjection = $MovementPredictionLine
@onready var l: Line3D = $Node3D

var pressed: bool
var input_start_position: Vector2
var direction: Vector3
var should_draw_projection: bool

func _process(delta):
	if agent.is_my_turn and pressed and should_draw_projection:
		agent_movement_projection.update_trajectory_3d(direction, agent.current_velocity, delta)
		agent_movement_projection.show()
		
		l.update_trajectory(direction, agent.current_velocity, delta)
		l.show()
	else:
		agent_movement_projection.hide()
#		l.hide()

func _input(event):
	if event is InputEventScreenTouch:
		var input = event.position
		
		if event.pressed:
			pressed = true
			should_draw_projection = false
			input_start_position = input
		else:
			pressed = false
			if input.distance_to(input_start_position) > distance_from_touch_location_to_count_play:
				agent.move(direction)
	elif event is InputEventScreenDrag:
		var input = event.position
		
		if input.distance_to(input_start_position) > distance_from_touch_location_to_count_play:
			var drag_delta = input.direction_to(input_start_position)
			direction = Vector3(drag_delta.x, 0, drag_delta.y)
			should_draw_projection = true
		else:
			should_draw_projection = false
