extends Node2D

class_name AgentMovementPrediction

@onready var prediction_line: Line2D = $PredictionLine
@onready var collision_check: CharacterBody2D = $CollisionCheck

@export var agent_collision_shape: CollisionShape2D

var agent_collision_shape_id: RID

func _ready() -> void:
	agent_collision_shape_id = agent_collision_shape.shape.get_rid()

func show_prediction(direction: Vector2, agent_speed: float, delta: float) -> void:
	var points = calculate_movement(direction, agent_speed, delta)
	prediction_line.points = points
	prediction_line.show()
	
	_get_position_before_collision(direction, agent_speed, delta)
	queue_redraw()

func _get_position_before_collision(direction: Vector2, agent_speed: float, delta: float) -> void:
	var p: Vector2 = Vector2.ZERO
	collision_check.position = p
	var velocity = direction * agent_speed
	var collision: KinematicCollision2D
	var d = delta
	var m = true
	while m:
		collision = collision_check.move_and_collide(velocity * d, true)
		while collision and collision.get_collider_shape().shape.get_rid() != agent_collision_shape_id and d > 0.002:
			d -= 0.001
			collision = collision_check.move_and_collide(velocity * d, true)
		if d <= 0.002:
			m = false
		p += velocity * d
		collision_check.position = p

func calculate_movement(direction: Vector2, agent_speed: float, delta: float) -> PackedVector2Array:
	var points = PackedVector2Array()
	var space_state = get_world_2d().direct_space_state
	var current_position : Vector2 = global_position
	var velocity = direction * agent_speed
	var last_position: Vector2
	for i in 300:
		last_position = current_position
		points.append(current_position)
		current_position += velocity * delta
		var query = PhysicsRayQueryParameters2D.create(last_position, current_position)
		query.collide_with_areas = true
		query.collision_mask = 1
		var result = space_state.intersect_ray(query)
		if result:
			break
	return points

func _draw():
	var angles = [
		{"start": 2.5, "end": 42.5},
		{"start": 47.5, "end": 87.5},
		{"start": 92.5, "end": 132.5},
		{"start": 137.5, "end": 177.5},
		{"start": 182.5, "end": 222.5},
		{"start": 227.5, "end": 267.5},
		{"start": 272.5, "end": 312.5},
		{"start": 317.5, "end": 357.5}
	]
	for a in angles:
		draw_circle_arc(collision_check.position, agent_collision_shape.shape.radius, a.start, a.end, Color.WHITE)

func draw_circle_arc(center, radius, angle_from, angle_to, color):
	var nb_points = 32
	var points_arc = PackedVector2Array()

	for i in range(nb_points + 1):
		var angle_point = deg_to_rad(angle_from + i * (angle_to-angle_from) / nb_points - 90)
		points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)

	for index_point in range(nb_points):
		draw_line(points_arc[index_point], points_arc[index_point + 1], color, 2)
