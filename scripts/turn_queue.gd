extends Node

class_name TurnQueue

@export var victory_event_channel: VoidEventChannel
@export var defeat_event_channel: VoidEventChannel
@export var turn_time_in_secs : float = 10
@export var turn_label : Label
@export var turn_countdown_progress_bar: ProgressBar

@export var play_sfx_event_channel: AudioCueEventChannel
@export var timer_countdown_audio: AudioCue
@export var sfx_2d_audio_config: AudioConfiguration

@onready var timer = $TurnTimer
@onready var agents = get_tree().get_nodes_in_group("Agents")

var _active_agent_index = -1
var _active_agent: Agent
var _running : bool = false

func _ready():
	timer.wait_time = turn_time_in_secs
	timer.timeout.connect(_end_turn)
	turn_countdown_progress_bar.max_value = turn_time_in_secs
	turn_countdown_progress_bar.value = turn_time_in_secs
	for agent in agents:
		agent.turn_ended.connect(_end_turn)
		agent.moved.connect(_on_agent_moved)
	get_tree().create_timer(1).timeout.connect(start)

func _process(delta):
	if Input.is_action_just_pressed("Test"):
		start()
	if _running and not timer.is_stopped():
		turn_countdown_progress_bar.value = timer.time_left

func start():
	if !_running:
		print("Starting the turn queue")
		_running = true
		_start_turn()

func stop():
	if _running:
		print("Stoping the turn queue")
		timer.stop()
		_running = false

func _start_turn():
	if _running:
		turn_countdown_progress_bar.value = turn_time_in_secs
		_active_agent = _get_next_live_agent()
		print("Starting turn of ", _active_agent_index, " ", _active_agent)
		turn_label.modulate.a = 1
		turn_label.text = _active_agent.name + "'s turns"
		get_tree().create_timer(1).timeout.connect(_fade_label)
		_active_agent.change_turn(true)
		timer.start()

func _end_turn():
	print("Ending turn of ", _active_agent_index, " ", _active_agent)
	_active_agent.change_turn(false)
	_kill_dead_agents()
	_start_turn()

func _get_next_live_agent() -> Agent:
	var live_agents = agents.filter(func (a: Agent): return not a.dead)
	_active_agent_index = (_active_agent_index + 1) % live_agents.size()
	return live_agents[_active_agent_index]

func _on_agent_moved():
	timer.stop()

func _fade_label():
	var tween = turn_label.create_tween()
	tween.tween_property(turn_label, "modulate:a", 0, 1).set_trans(Tween.TRANS_SINE)
	await tween.finished

func _kill_dead_agents():
	var dead_agents = agents.filter(func (a: Agent): return a.dead)
	for agent in dead_agents:
		agent.kill()
		if agent is PlayerAgent:
			defeat_event_channel.raise_event()
			stop()
	if agents.filter(func (a: Agent): return a is AiAgent).all(func (a: Agent): return a.dead):
		print("Player won the game")
		victory_event_channel.raise_event()
		stop()

func _play_countdown_audio():
	play_sfx_event_channel.raise_event(timer_countdown_audio, sfx_2d_audio_config)

func _get_tool_buttons():
	return [start]
