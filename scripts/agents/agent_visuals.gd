extends Node2D

@onready var agent : Agent = get_parent()

func _physics_process(delta):
	self.rotation = -agent.rotation
