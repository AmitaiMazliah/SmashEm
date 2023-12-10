extends Node2D

@export var distance_from_touch_location_to_count_play : float = 60
@export var agent_movement_projection: AgentMovementPrediction
@export var max_points_to_predict: int = 300

@onready var agent: Agent2D = self.get_parent()
@onready var camera: Camera3D = get_viewport().get_camera_3d()

var pressed: bool
var input_start_position: Vector2
var direction: Vector2
var should_draw_projection: bool

func _ready():
	agent.is_player = true

func _process(delta) -> void:
	if agent.is_my_turn and pressed and should_draw_projection:
		agent_movement_projection.show_prediction(direction, agent.current_velocity, delta)
		agent_movement_projection.show()
	else:
		#$Node2D/TestDraw.hide()
		agent_movement_projection.hide()
		#var d = 5

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
			direction = input.direction_to(input_start_position)
			should_draw_projection = true
		else:
			should_draw_projection = false
