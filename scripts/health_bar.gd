extends Control

@export var agent : Agent2D
@onready var progress_bar : ProgressBar = $ProgressBar

func _process(_delta):
	progress_bar.max_value = agent.max_health
	progress_bar.value = agent.current_health
