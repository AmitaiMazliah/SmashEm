extends Line2D

@export var max_points_to_predict = 300
@export var gravity = 0

func update_trajectory(direction: Vector2, speed: float, delta: float):
	clear_points()
	var position : Vector2 = Vector2.ZERO
	var velocity = direction * speed
	for i in max_points_to_predict:
		add_point(position)
		velocity.y += gravity * delta
		position += velocity * delta
