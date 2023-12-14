extends Node2D

class_name AgentWallCollisionEffect

@onready var vfx: AnimatedSprite2D = $VFX

@export var animations_count: int = 3

func _ready() -> void:
	randomize()
	var random_animation_index = randi_range(0, animations_count - 1)
	vfx.play("v" + str(random_animation_index))
	print("Using v" + str(random_animation_index))
	vfx.animation_looped.connect(_on_all_effects_ended)

func _on_all_effects_ended():
	queue_free()
