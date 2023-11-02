extends Control

@onready var progress_bar : ProgressBar = $ProgressBar
@onready var agent : Agent = get_parent()

func _process(delta):
	progress_bar.max_value = agent.health.max_health
	progress_bar.value = agent.health.current_health
