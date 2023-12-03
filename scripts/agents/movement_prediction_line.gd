extends Line2D

class_name AgentMovementProjection

@export var max_points_to_predict = 300
@export_range(1, 100) var precision = 1
@export var gravity = 0

func update_trajectory(direction: Vector2, speed: float, delta: float):
	clear_points()
	delta /= precision
	var position : Vector2 = Vector2.ZERO
	$CollisionCheck.position = position
	var velocity = direction * speed
	for i in max_points_to_predict:
		add_point(position)
		velocity.y += gravity * delta
		position += velocity * delta
		var collision = $CollisionCheck.move_and_collide(velocity * delta, true, true, true)
		if collision:
			return
		$CollisionCheck.position = position
