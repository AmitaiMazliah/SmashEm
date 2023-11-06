extends Resource

class_name AudioConfiguration

@export var audio_bus: AudioBusName

@export_category("Sound properties")
@export var mute : bool = false
@export_range(0, 1) var volume : float = 1
@export_range(0, 1) var pitch : float = 1

func apply_to(audio_stream_player):
	audio_stream_player.volume_db = volume
	audio_stream_player.pitch_scale = pitch
	audio_stream_player.bus = AudioBusName.keys()[audio_bus]

enum AudioBusName { Music, SFX_2D, SFX_UI }
