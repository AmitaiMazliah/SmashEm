extends Resource

class_name AudioCueEventChannel

signal event_raised(audio_cue: AudioCue)

func raise_event(audio_cue : AudioCue, g: int, f: String) -> void:
	event_raised.emit(audio_cue)
