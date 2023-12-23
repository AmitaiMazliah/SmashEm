extends Area2D

class_name Projectile

var _owner: Agent2D
var _velocity: Vector2
var _damage: int

func fire(owner:Agent2D, direction: Vector2, speed: float, damage: int) -> void:
	_owner = owner
	_velocity = direction * speed
	_damage = damage

func _process(delta: float) -> void:
	translate(_velocity)

func _on_body_entered(body: Node2D) -> void:
	if body is StaticBody2D:
		queue_free()
	elif body is Agent2D and body != _owner:
		(body as Agent2D).take_damage(_damage)
		print("collided with ", body.name)
