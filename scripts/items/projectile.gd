extends Area2D

class_name Projectile

signal destroyed

@export var damage: int

var _owner: Agent2D
var _velocity: Vector2

func fire(owner:Agent2D, direction: Vector2, speed: float) -> void:
	_owner = owner
	_velocity = direction * speed

func _process(delta: float) -> void:
	translate(_velocity)

func _on_body_entered(body: Node2D) -> void:
	if body is StaticBody2D:
		destroyed.emit()
		queue_free()
	elif body is Agent2D and body != _owner:
		(body as Agent2D).take_damage(damage)
		print("collided with ", body.name)
