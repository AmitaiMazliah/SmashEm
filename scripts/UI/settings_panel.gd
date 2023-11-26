extends Control

class_name SettingsPanel

@onready var _music_on_button: Button = $SettingsPanel/MarginContainer/InnerSettingsPanel/MarginContainer/VBoxContainer/MusicSetting/OnButton
@onready var _music_off_button: Button = $SettingsPanel/MarginContainer/InnerSettingsPanel/MarginContainer/VBoxContainer/MusicSetting/OffButton

@onready var _sfx_on_button: Button = $SettingsPanel/MarginContainer/InnerSettingsPanel/MarginContainer/VBoxContainer/SfxSetting/OnButton
@onready var _sfx_off_button: Button = $SettingsPanel/MarginContainer/InnerSettingsPanel/MarginContainer/VBoxContainer/SfxSetting/OffButton

@export var _change_music_volume: FloatEventChannel
@export var _change_sfx_2d_volume: FloatEventChannel
@export var _change_sfx_ui_volume: FloatEventChannel

func _ready():
	_music_off_button.hide()
	_sfx_off_button.hide()
	
	_music_on_button.pressed.connect(_on_toggle_music.bind(false))
	_music_off_button.pressed.connect(_on_toggle_music.bind(true))
	_sfx_on_button.pressed.connect(_on_toggle_sfx.bind(false))
	_sfx_off_button.pressed.connect(_on_toggle_sfx.bind(true))

func _on_close_button_pressed():
	hide()

func _on_blur_background_pressed():
	hide()

func _on_toggle_music(on: bool) -> void:
	if on:
		_music_off_button.hide()
		_music_on_button.show()
		_change_music_volume.raise_event(0)
	else:
		_music_on_button.hide()
		_music_off_button.show()
		_change_music_volume.raise_event(-80)

func _on_toggle_sfx(on: bool) -> void:
	if on:
		_sfx_off_button.hide()
		_sfx_on_button.show()
		_change_sfx_2d_volume.raise_event(0)
		_change_sfx_ui_volume.raise_event(0)
	else:
		_sfx_on_button.hide()
		_sfx_off_button.show()
		_change_sfx_2d_volume.raise_event(-80)
		_change_sfx_ui_volume.raise_event(-80)
