extends Node2D

class_name AgentMovementPrediction

@onready var prediction_line: Line2D = $PredictionLine
@onready var shape_cast_2d: ShapeCast2D = $ShapeCast2D

@export var agent_collision_shape: CollisionShape2D

var draw_center: Vector2

func show_prediction(direction: Vector2, agent_speed: float, delta: float) -> void:
	var points = calculate_movement(direction, agent_speed, delta)
	prediction_line.points = points
	prediction_line.show()
	
	draw_center = _get_position_before_colision(direction)
	queue_redraw()

func _get_position_before_colision(direction: Vector2) -> Vector2:
	var to = global_position + (direction * 1000)
	var query = PhysicsRayQueryParameters2D.create(global_position, to)
	query.collide_with_areas = true
	var space_state = get_world_2d().direct_space_state
	var result = space_state.intersect_ray(query)
	if result:
		var target_position = to_local(result.position)
		shape_cast_2d.target_position = target_position
		return target_position * shape_cast_2d.get_closest_collision_unsafe_fraction()
	else:
		return Vector2.ZERO

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

func _draw() -> void:
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
		_draw_circle_arc(draw_center, agent_collision_shape.shape.radius, a.start, a.end, Color.WHITE)

func _draw_circle_arc(center, radius, angle_from, angle_to, color):
	var nb_points = 32
	var points_arc = PackedVector2Array()

	for i in range(nb_points + 1):
		var angle_point = deg_to_rad(angle_from + i * (angle_to-angle_from) / nb_points - 90)
		points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)

	for index_point in range(nb_points):
		draw_line(points_arc[index_point], points_arc[index_point + 1], color, 2)
