extends Node

@export var sound_emitter_pool_size: int = 10
@export var play_sound_audio_event_channel : AudioCueEventChannel
@export var play_music_audio_event_channel : AudioCueEventChannel

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
	_generate_audio_pool()
	play_sound_audio_event_channel.play_audio.connect(_on_play_sound_audio_cue)
	play_music_audio_event_channel.play_audio.connect(_on_play_music_audio_cue)

func _generate_audio_pool():
	for i in sound_emitter_pool_size:
		var sound_emitter = SoundEmitter.new()
		add_child(sound_emitter)
		_sound_emitter_pool.append(sound_emitter)
		sound_emitter.finished.connect(_on_stream_player_finished.bind(sound_emitter))

func _on_play_music_audio_cue(audio_cue: AudioCue, audio_config: AudioConfiguration, position: Vector2 = Vector2.ZERO):
	if _music_sound_emitter and _music_sound_emitter.playing:
		# Music is already playing, need to fade it out
		_music_sound_emitter.fade_out(2)
		#startTime = musicSoundEmitter.FadeMusicOut(fadeDuration);
	
	var clip_to_play = audio_cue.get_next_clip()
	_music_sound_emitter = _sound_emitter_pool.pop_back();
	print(clip_to_play)
	_music_sound_emitter.play_audio_clip(clip_to_play, audio_config, false, position)

func _on_play_sound_audio_cue(audio_cue: AudioCue, audio_config: AudioConfiguration, position: Vector2 = Vector2.ZERO):
	var clip_to_play = audio_cue.get_next_clip()
	var sound_emitter = _sound_emitter_pool.pop_back();
	print(clip_to_play)
	sound_emitter.play_audio_clip(clip_to_play, audio_config, false, position)

func _on_stream_player_finished(sound_emitter):
	if sound_emitter:
		_sound_emitter_pool.append(sound_emitter)
		sound_emitter.set_process(false)
