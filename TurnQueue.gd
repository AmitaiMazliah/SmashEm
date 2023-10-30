extends Node

class_name TurnQueue

@onready var agents = get_tree().get_nodes_in_group("Agents")
var active_agent_index = 0

func _process(delta):
	if Input.is_action_just_pressed("Test"):
		print("test")
		play_turn()

func play_turn():
	var active_agent = agents[active_agent_index]
	print("now turn of ", active_agent_index, " ", active_agent)
	active_agent.change_turn(true)
	await get_tree().create_timer(10).timeout
	#await active_agent.end_turn
	active_agent.change_turn(false)
	active_agent_index = (active_agent_index + 1) % agents.size()
