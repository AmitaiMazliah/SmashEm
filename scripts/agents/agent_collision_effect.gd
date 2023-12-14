extends Node2D

class_name AgentCollisionEffect

@onready var smoke_effect: AnimatedSprite2D = $SmokeAnimatedSprite2D

func _ready() -> void:
	smoke_effect.play("default")
	smoke_effect.animation_looped.connect(_on_all_effects_ended)

func _on_all_effects_ended():
	queue_free()
