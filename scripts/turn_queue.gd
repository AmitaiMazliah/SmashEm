extends Node

class_name TurnQueue

@export var victory_event_channel: VoidEventChannel
@export var defeat_event_channel: VoidEventChannel
@export var turn_changed_event_channel: VoidEventChannel
@export var turn_time_in_secs : float = 10
@export var turn_label : Label
@export var turn_countdown_progress_bar: ProgressBar

@export var play_sfx_event_channel: AudioCueEventChannel
@export var timer_countdown_audio: AudioCue
@export var sfx_2d_audio_config: AudioConfiguration

@onready var timer = $TurnTimer
@onready var agents = get_tree().get_nodes_in_group("Agents")

var _active_agent_index = -1
var _active_agent: Agent2D
var _active_agent_started_moving: bool
var _running : bool
var _countdown_timers: Array[SceneTreeTimer]

func _ready():
	timer.wait_time = turn_time_in_secs
	timer.timeout.connect(_end_turn)
	turn_countdown_progress_bar.max_value = turn_time_in_secs
	turn_countdown_progress_bar.value = turn_time_in_secs
	for agent: Agent2D in agents:
		agent.moved.connect(_on_agent_moved)
	get_tree().create_timer(1).timeout.connect(start)

func _process(_delta):
	if _running:
		agents = agents.filter(func (a: Agent2D): return a != null)
		if not timer.is_stopped():
			turn_countdown_progress_bar.value = timer.time_left
		if _active_agent_started_moving:
			if agents.all(func (a: Agent2D): return not a.moving):
				print("All agents came to a stop, ending turn")
				_end_turn()
		
		_active_agent_started_moving = agents.any(func (a): return a.moving)

func start():
	if !_running:
		print("Starting the turn queue")
		_running = true
		randomize()
		agents.shuffle()
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
		turn_changed_event_channel.raise_event()
		_active_agent.start_turn()
		timer.start()
		_countdown_timers = [
			get_tree().create_timer(turn_time_in_secs - 3),
			get_tree().create_timer(turn_time_in_secs - 2),
			get_tree().create_timer(turn_time_in_secs - 1)
		]
		for t in _countdown_timers:
			t.timeout.connect(_play_countdown_audio)

func _end_turn() -> void:
	print("Ending turn of ", _active_agent_index, " ", _active_agent)
	await _active_agent.end_turn()
	await _kill_dead_agents()
	_start_turn()

func _get_next_live_agent() -> Agent2D:
	var live_agents = agents
	_active_agent_index = (_active_agent_index + 1) % live_agents.size()
	return live_agents[_active_agent_index]

func _on_agent_moved() -> void:
	timer.stop()
	for t in _countdown_timers:
		t.timeout.disconnect(_play_countdown_audio)

func _fade_label() -> void:
	var tween = turn_label.create_tween()
	tween.tween_property(turn_label, "modulate:a", 0, 1).set_trans(Tween.TRANS_SINE)
	await tween.finished

func _kill_dead_agents():
	var dead_agents = agents.filter(func (a: Agent2D): return a.current_health <= 0)
	if len(dead_agents) > 0:
		var is_player_dead = dead_agents.any(func (a: Agent2D): return a.is_player)
		var promises: Array[Promise]
		promises.assign(dead_agents.map(func (a: Agent2D): return Promise.new(
			func(resolve: Callable, reject: Callable):
				await a.die()
				resolve.call("")
		)))
		var result = await Promise.all(promises).settled
		if result.status == Promise.Status.RESOLVED:
			print("Done killing ", len(dead_agents), " agents")
			if is_player_dead:
				print("Player lost the match")
				defeat_event_channel.raise_event()
				stop()
			elif len(agents) == 1:
				print("Player won the match")
				victory_event_channel.raise_event()
				stop()

func _play_countdown_audio():
	play_sfx_event_channel.raise_play_event(timer_countdown_audio, sfx_2d_audio_config)

func _get_tool_buttons():
	return [start]
