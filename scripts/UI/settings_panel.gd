extends Control

class_name SettingsPanel

const MUSIC_VOLUME_KEY = "MusicVolume"
const SFX_VOLUME_KEY = "SfxVolume"

@onready var _music_on_button: Button = $SettingsPanel/MarginContainer/InnerSettingsPanel/MarginContainer/VBoxContainer/MusicSetting/OnButton
@onready var _music_off_button: Button = $SettingsPanel/MarginContainer/InnerSettingsPanel/MarginContainer/VBoxContainer/MusicSetting/OffButton

@onready var _sfx_on_button: Button = $SettingsPanel/MarginContainer/InnerSettingsPanel/MarginContainer/VBoxContainer/SfxSetting/OnButton
@onready var _sfx_off_button: Button = $SettingsPanel/MarginContainer/InnerSettingsPanel/MarginContainer/VBoxContainer/SfxSetting/OffButton

@export var _save_system: SaveSystem
@export var _change_music_volume: FloatEventChannel
@export var _change_sfx_2d_volume: FloatEventChannel
@export var _change_sfx_ui_volume: FloatEventChannel

func _ready():
	var saved_music_volume = _save_system.get_value(MUSIC_VOLUME_KEY, 0)
	_on_toggle_music(saved_music_volume == 0)
	var saved_sfx_volume = _save_system.get_value(SFX_VOLUME_KEY, 0)
	_on_toggle_sfx(saved_sfx_volume == 0)
	
	_music_on_button.pressed.connect(_on_toggle_music.bind(false))
	_music_off_button.pressed.connect(_on_toggle_music.bind(true))
	_sfx_on_button.pressed.connect(_on_toggle_sfx.bind(false))
	_sfx_off_button.pressed.connect(_on_toggle_sfx.bind(true))

func _on_close_button_pressed():
	_save_system.save()
	hide()

func _on_blur_background_pressed():
	_save_system.save()
	hide()

func _on_toggle_music(on: bool) -> void:
	if on:
		_music_off_button.hide()
		_music_on_button.show()
		_change_music_volume.raise_event(0)
		_save_system.set_value(MUSIC_VOLUME_KEY, 0, false)
	else:
		_music_on_button.hide()
		_music_off_button.show()
		_change_music_volume.raise_event(-80)
		_save_system.set_value(MUSIC_VOLUME_KEY, -80, false)

func _on_toggle_sfx(on: bool) -> void:
	if on:
		_sfx_off_button.hide()
		_sfx_on_button.show()
		_change_sfx_2d_volume.raise_event(0)
		_change_sfx_ui_volume.raise_event(0)
		_save_system.set_value(SFX_VOLUME_KEY, 0, false)
	else:
		_sfx_on_button.hide()
		_sfx_off_button.show()
		_change_sfx_2d_volume.raise_event(-80)
		_change_sfx_ui_volume.raise_event(-80)
		_save_system.set_value(SFX_VOLUME_KEY, -80, false)
