extends Control

@export var load_scene_event_channel: LoadSceneEventChannel
@export var game_scene: GameScene

@onready var _settings_panel: SettingsPanel = $MarginContainer/SettingsPanel

func _ready():
	_settings_panel.hide()

func on_close():
	_settings_panel.hide()

func _on_play_button_pressed():
	load_scene_event_channel.raise_event(game_scene)

func _on_settings_button_pressed():
	_settings_panel.show()
