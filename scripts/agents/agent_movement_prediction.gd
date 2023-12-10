extends Node2D

class_name AgentMovementPrediction

@onready var prediction_line: Line2D = $PredictionLine
@onready var collision_check: CharacterBody2D = $CollisionCheck

func show_prediction(direction: Vector2, agent_speed: float, delta: float) -> void:
	var points = calculate_movement(direction, agent_speed, delta)
	prediction_line.points = points
	prediction_line.show()
	
	var p : Vector2 = Vector2.ZERO
	collision_check.position = p
	var velocity = direction * agent_speed
	var collision: KinematicCollision2D
	var d = delta
	var m = true
	while m:
		collision = collision_check.move_and_collide(velocity * d, true)
		while collision and collision.get_collider_shape() != $CollisionCheck/CollisionShape2D.shape and d > 0.002:
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
