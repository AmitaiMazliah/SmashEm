extends AudioStreamPlayer

class_name SoundEmitter

func _ready():
	autoplay = false

func play_audio_clip(audio_clip: AudioStream, has_to_loop: bool):
	stream = audio_clip
	play()
