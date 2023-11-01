extends Resource

class_name AudioConfiguration

@export_category("Sound properties")
@export var mute : bool = false
@export_range(0, 1) var volume : float = 1
@export_range(0, 1) var pitch : float = 1

func apply_to(audio_stream_player):
	audio_stream_player.volume_db = volume
	audio_stream_player.pitch_scale = pitch
