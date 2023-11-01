extends Resource

class_name AudioCueEventChannel

signal event_raised(audio_cue: AudioCue, audio_config: AudioConfiguration, position: Vector2)

func raise_event(audio_cue : AudioCue, audio_config: AudioConfiguration, position: Vector2 = Vector2.ZERO) -> void:
	event_raised.emit(audio_cue, audio_config, position)
