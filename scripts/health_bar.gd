extends Control

@export var health : HealthComponent
@onready var progress_bar : ProgressBar = $ProgressBar

func _process(_delta):
	progress_bar.max_value = health.max_health
	progress_bar.value = health.current_health
