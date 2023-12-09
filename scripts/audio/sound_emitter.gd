extends AudioStreamPlayer2D

class_name SoundEmitter

func _ready():
	autoplay = false

func play_audio_clip(audio_clip: AudioStream, audio_config: AudioConfiguration, has_to_loop: bool, _position: Vector2 = Vector2.ZERO):
	position = _position
	audio_config.apply_to(self)
	stream = audio_clip
	play()

func fade_music_in(audio_clip: AudioStream, audio_config: AudioConfiguration, duration: float, start_time: float = 0):
	play_audio_clip(audio_clip, audio_config, true)
	var desired_volume = volume_db
	volume_db = -80
	var tween = create_tween()
	tween.tween_property(self, "volume_db", desired_volume, duration).set_trans(Tween.TRANS_SINE)

func fade_out(duration: float):
	var tween = create_tween()
	tween.tween_property(self, "volume_db", -80, duration).set_trans(Tween.TRANS_SINE)
	tween.finished.connect(_on_fade_out_completed)

func _on_fade_out_completed():
	# stop the music -- otherwise it continues to run at silent volume
	stop()
