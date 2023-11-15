extends AudioStreamPlayer2D

class_name SoundEmitter

func _ready():
	autoplay = false

func play_audio_clip(audio_clip: AudioStream, audio_config: AudioConfiguration, has_to_loop: bool, position: Vector2 = Vector2.ZERO):
	self.position = position
	audio_config.apply_to(self)
	stream = audio_clip
	play()

func fade_in():
	print("fade in")

func fade_out(duration: float):
	var tween = create_tween()
	# tween music volume down to 0
	tween.tween_property(self, "volume_db", -80, duration).set_trans(Tween.TRANS_SINE)
	tween.finished.connect(_on_fade_out_completed)
	# when the tween ends, the music will be stopped

func _on_fade_out_completed():
	# stop the music -- otherwise it continues to run at silent volume
	stop()
