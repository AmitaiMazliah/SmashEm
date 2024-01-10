extends Area2D

@export var max_turn_count: int = 3
@export var damage_per_turn: int = 10

var _passed_turn_count: int

func on_turn_changed():
	if has_overlapping_bodies():
		for body in get_overlapping_bodies():
			if body is Agent2D:
				var agent = body as Agent2D
				agent.take_damage(damage_per_turn)
	_passed_turn_count += 1
	if _passed_turn_count >= max_turn_count:
		queue_free()
