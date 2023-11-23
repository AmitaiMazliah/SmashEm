extends Control

@export var load_scene_event_channel: LoadSceneEventChannel
@export var game_scene: GameScene

@onready var _settings_panel: SettingsPanel = $MarginContainer/Control/SettingsPanel
@onready var _chests_area: ChestArea = $MarginContainer/Control/ChestsArea

func _ready():
	_settings_panel.hide()
	_chests_area.set_chests(Player.chests)

func on_close():
	_settings_panel.hide()

func _on_play_button_pressed():
	load_scene_event_channel.raise_event(game_scene, false)

func _on_settings_button_pressed():
	_settings_panel.show()
