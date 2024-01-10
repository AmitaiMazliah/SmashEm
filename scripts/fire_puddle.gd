extends Area2D

@export var max_turn_count: int = 3
@export var damage_per_turn: int = 10

var _passed_turn_count: int
var _owner: Agent2D

func set_agent(owner: Agent2D) -> void:
	_owner = owner

func on_turn_changed() -> void:
	if has_overlapping_bodies():
		for body in get_overlapping_bodies():
			if body is Agent2D and body != _owner:
				var agent = body as Agent2D
				agent.take_damage(damage_per_turn)
	_passed_turn_count += 1
	if _passed_turn_count >= max_turn_count:
		_owner.remove_spawn(self)
		queue_free()
