extends Resource

class_name AudioCueEventChannel

signal play_audio(audio_cue: AudioCue, audio_config: AudioConfiguration, position: Vector2)
signal stop_audio()

func raise_play_event(audio_cue : AudioCue, audio_config: AudioConfiguration, position: Vector2 = Vector2.ZERO) -> void:
	play_audio.emit(audio_cue, audio_config, position)

func raise_stop_event() -> void:
	stop_audio.emit()
