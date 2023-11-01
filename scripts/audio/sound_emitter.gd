extends AudioStreamPlayer2D

class_name SoundEmitter

func _ready():
	autoplay = false

func play_audio_clip(audio_clip: AudioStream, audio_config: AudioConfiguration, has_to_loop: bool, position: Vector2 = Vector2.ZERO):
	self.position = position
	audio_config.apply_to(self)
	stream = audio_clip
	play()
