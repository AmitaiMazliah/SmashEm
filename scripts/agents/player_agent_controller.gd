extends Node3D

@export var distance_from_touch_location_to_count_play : float = 60
@export var agent_movement_projection: AgentMovementProjection
@export var max_points_to_predict: int = 300

@onready var agent: MyAgent = self.get_parent()
@onready var camera: Camera3D = get_viewport().get_camera_3d()

var pressed: bool
var input_start_position: Vector2
var direction: Vector3
var should_draw_projection: bool

func _ready():
	agent.is_player = true

func _process(delta):
	if agent.is_my_turn and pressed and should_draw_projection:
		var points = calculate_movement(direction, delta)
		agent_movement_projection.points = points
		agent_movement_projection.show()
	else:
		agent_movement_projection.hide()

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

func calculate_movement(direction: Vector3, delta: float) -> PackedVector2Array:
	var points = PackedVector2Array()
	var space_state = get_world_3d().direct_space_state
	var position : Vector3 = global_position
	var velocity = direction * agent.current_velocity
	var last_position: Vector3
	for i in max_points_to_predict:
		last_position = position
		points.append(camera.unproject_position(position))
		position += velocity * delta
		var query = PhysicsRayQueryParameters3D.create(last_position, position)
		query.collide_with_areas = true
		var result = space_state.intersect_ray(query)
		if result:
			break
	return points
