extends Node2D

@export var distance_from_touch_location_to_count_play : float = 60
@export var agent_movement_projection: AgentMovementPrediction

@onready var agent: Agent2D = self.get_parent()

var pressed: bool
var input_start_position: Vector2
var direction: Vector2
var should_draw_projection: bool

func _ready() -> void:
	agent.is_player = true

func _physics_process(delta: float) -> void:
	if agent.is_my_turn and pressed and should_draw_projection:
		agent_movement_projection.show_prediction(direction, agent.current_velocity, delta)
		agent_movement_projection.show()
	else:
		agent_movement_projection.hide()

func _input(event: InputEvent) -> void:
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
