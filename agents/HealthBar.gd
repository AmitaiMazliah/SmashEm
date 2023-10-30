extends Control

var progress_bar : ProgressBar
var agent : Agent

func _ready():
	progress_bar = $ProgressBar
	agent = get_parent()
	progress_bar.max_value = agent.max_health

func _process(delta):
	progress_bar.value = agent.current_health
