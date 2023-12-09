extends Node2D

@onready var agent : Agent2D = get_parent()

func _physics_process(_delta):
	self.rotation = -agent.rotation
