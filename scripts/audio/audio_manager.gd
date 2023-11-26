extends Node

@export var sound_emitter_pool_size: int = 10
@export var play_sound_audio_event_channel : AudioCueEventChannel
@export var play_music_audio_event_channel : AudioCueEventChannel
@export var _change_music_volume: FloatEventChannel
@export var _change_sfx_2d_volume: FloatEventChannel
@export var _change_sfx_ui_volume: FloatEventChannel

var _sound_emitter_pool : Array[SoundEmitter]
var _music_sound_emitter: SoundEmitter

@export var _test_audio_cue : AudioCue
@export var _test_audio_config : AudioConfiguration

func _get_tool_buttons():
	return [test_audio_cue]

func test_audio_cue():
	if _test_audio_cue:
		_on_play_sound_audio_cue(_test_audio_cue, _test_audio_config)

func _ready():
	_change_music_volume.event_raised.connect(_change_audio_bus_volume.bind(AudioConfiguration.AudioBusName.Music))
	_change_sfx_2d_volume.event_raised.connect(_change_audio_bus_volume.bind(AudioConfiguration.AudioBusName.SFX_2D))
	_change_sfx_ui_volume.event_raised.connect(_change_audio_bus_volume.bind(AudioConfiguration.AudioBusName.SFX_UI))
	_generate_audio_pool()
	play_sound_audio_event_channel.play_audio.connect(_on_play_sound_audio_cue)
	play_music_audio_event_channel.play_audio.connect(_on_play_music_audio_cue)

func _generate_audio_pool():
	for i in sound_emitter_pool_size:
		var sound_emitter = SoundEmitter.new()
		add_child(sound_emitter)
		_sound_emitter_pool.append(sound_emitter)
		sound_emitter.finished.connect(_on_stream_player_finished.bind(sound_emitter))

func _change_audio_bus_volume(volume: float, bus_name: AudioConfiguration.AudioBusName):
	var bus_index = AudioServer.get_bus_index(AudioConfiguration.AudioBusName.keys()[bus_name])
	AudioServer.set_bus_volume_db(bus_index, volume)

func _on_play_music_audio_cue(audio_cue: AudioCue, audio_config: AudioConfiguration, position: Vector2 = Vector2.ZERO):
	if _music_sound_emitter and _music_sound_emitter.playing:
		_music_sound_emitter.fade_out(2)
	
	var clip_to_play = audio_cue.get_next_clip()
	_music_sound_emitter = _sound_emitter_pool.pop_back();
	print(clip_to_play)
	_music_sound_emitter.fade_music_in(clip_to_play, audio_config, 1)

func _on_play_sound_audio_cue(audio_cue: AudioCue, audio_config: AudioConfiguration, position: Vector2 = Vector2.ZERO):
	var clip_to_play = audio_cue.get_next_clip()
	var sound_emitter = _sound_emitter_pool.pop_back();
	print(clip_to_play)
	sound_emitter.play_audio_clip(clip_to_play, audio_config, false, position)

func _on_stream_player_finished(sound_emitter):
	if sound_emitter:
		_sound_emitter_pool.append(sound_emitter)
		sound_emitter.set_process(false)
