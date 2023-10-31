extends Node

class_name TurnQueue

@export var turn_time_in_secs : float = 10

@onready var timer = $TurnTimer
@onready var agents = get_tree().get_nodes_in_group("Agents")

var _active_agent_index = 0
var _running : bool = false

func _ready():
	timer.wait_time = turn_time_in_secs

func _process(delta):
	if Input.is_action_just_pressed("Test"):
		start()

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
		var active_agent = agents[_active_agent_index]
		print("now turn of ", _active_agent_index, " ", active_agent)
		active_agent.change_turn(true)
		timer.start()
		var p: Promise = Promise.new([
			timer.timeout,
			active_agent.end_turn
		], Promise.MODE.ANY)
		var data = await p.completed
		active_agent.change_turn(false)
		_active_agent_index = (_active_agent_index + 1) % agents.size()
