extends Button

class_name UIButton

var _play_sfx_event_channel: AudioCueEventChannel = load("res://resources/events/play_sound_event_channel.tres")
var _sfx_ui_audio_config: AudioConfiguration = load("res://resources/audio/config/sfx_config.tres")
var _default_click_sound: AudioCue = load("res://resources/audio/cues/default_button_click.tres")

@export var on_click_sound_override: AudioCue

func _pressed():
	if on_click_sound_override:
		_play_sfx_event_channel.raise_play_event(on_click_sound_override, _sfx_ui_audio_config)
	else:
		_play_sfx_event_channel.raise_play_event(_default_click_sound, _sfx_ui_audio_config)
