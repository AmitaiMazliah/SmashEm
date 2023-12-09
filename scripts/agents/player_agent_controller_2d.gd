extends Node2D

@export var distance_from_touch_location_to_count_play : float = 60
@export var agent_movement_projection: Line2D
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
		#var points = calculate_movement(direction, delta)
		#agent_movement_projection.points = points
		#agent_movement_projection.show()
		
		var p : Vector2 = Vector2.ZERO
		$Node2D/CollisionCheck.position = p
		var velocity = direction * agent.current_velocity
		var collision: KinematicCollision2D
		for i in 3000:
			collision = $Node2D/CollisionCheck.move_and_collide(velocity * delta, true)
			if collision:
				break
			p += velocity * delta
			$Node2D/CollisionCheck.position = p
		
		$Node2D/TestDraw.set_parameters(p, $Node2D/CollisionCheck/CollisionShape2D.shape.radius)
		$Node2D/TestDraw.show()
		$Node2D/CollisionCheck.position = Vector2.ZERO
		var f = 5
		
	else:
		$Node2D/TestDraw.hide()
		#agent_movement_projection.hide()
		var d = 5

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

func calculate_movement(_direction: Vector3, delta: float) -> PackedVector2Array:
	var points = PackedVector2Array()
	var space_state = get_world_2d().direct_space_state
	var current_position : Vector2 = global_position
	var velocity = _direction * agent.current_velocity
	var last_position: Vector2
	for i in max_points_to_predict:
		last_position = current_position
		points.append(current_position)
		current_position += velocity * delta
		var query = PhysicsRayQueryParameters2D.create(last_position, current_position)
		query.collide_with_areas = true
		var result = space_state.intersect_ray(query)
		if result:
			break
	return points
