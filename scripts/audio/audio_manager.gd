extends Node

@export var sound_emitter_pool_size: int = 10
@export var play_sound_audio_event_channel : AudioCueEventChannel

var _sound_emitter_pool : Array[SoundEmitter]

@export var _test_audio_cue : AudioCue
@export var _test_audio_config : AudioConfiguration

func _get_tool_buttons():
	return [test_audio_cue]

func test_audio_cue():
	if _test_audio_cue:
		_on_play_sound_audio_cue(_test_audio_cue, _test_audio_config)

func _ready():
	for i in sound_emitter_pool_size:
		var sound_emitter = SoundEmitter.new()
		add_child(sound_emitter)
		_sound_emitter_pool.append(sound_emitter)
		sound_emitter.finished.connect(_on_stream_player_finished.bind(sound_emitter))
	play_sound_audio_event_channel.event_raised.connect(_on_play_sound_audio_cue)
	test_audio_cue()

func _on_play_sound_audio_cue(audio_cue: AudioCue, audio_config: AudioConfiguration, position: Vector2 = Vector2.ZERO):
	var clip_to_play = audio_cue.get_next_clip()
	var sound_emitter = _sound_emitter_pool.pop_back();
	print(clip_to_play)
	sound_emitter.play_audio_clip(clip_to_play, audio_config, false, position)

func _on_stream_player_finished(sound_emitter):
	if sound_emitter:
		_sound_emitter_pool.append(sound_emitter)
		sound_emitter.set_process(false)
