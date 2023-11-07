extends Node

class_name TurnQueue

@export var victory_event_channel: VoidEventChannel
@export var defeat_event_channel: VoidEventChannel
@export var turn_time_in_secs : float = 10
@export var turn_label : Label
@export var turn_countdown_progress_bar: ProgressBar

@onready var timer = $TurnTimer
@onready var agents = get_tree().get_nodes_in_group("Agents")
@onready var label_fade_timer = $LabelDisappearTimer

var _active_agent_index = 0
var _running : bool = false

func _ready():
	timer.wait_time = turn_time_in_secs
	turn_countdown_progress_bar.max_value = turn_time_in_secs
	turn_countdown_progress_bar.value = turn_time_in_secs
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
		play_turn()

func stop():
	if _running:
		print("Stoping the turn queue")
		_running = false

func play_turn():
	while (_running):
		var live_agents = agents.filter(func (a: Agent): return not a.dead)
		var active_agent = live_agents[_active_agent_index]
		print("now turn of ", _active_agent_index, " ", active_agent)
		turn_label.modulate.a = 1
		turn_label.text = active_agent.name + "'s turns"
		label_fade_timer.start()
		await label_fade_timer.timeout
		_fade_label()
		active_agent.change_turn(true)
		timer.start()
		var result = await Promise.any([
			Promise.from(timer.timeout),
			Promise.from(active_agent.turn_ended)
		]).settled
		if result.status == Promise.Status.RESOLVED:
			active_agent.change_turn(false)
			_kill_dead_agents()
			live_agents = agents.filter(func (a: Agent): return not a.dead)
			_active_agent_index = (_active_agent_index + 1) % live_agents.size()

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

func _get_tool_buttons():
	return [start]
