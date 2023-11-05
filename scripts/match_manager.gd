extends Node

class_name MatchManager

@onready var ai_agents = get_tree().get_nodes_in_group("AI_Agents")

@export var victory_event_channel: VoidEventChannel

func _process(delta):
	if ai_agents.all(func (a: Agent): return a.dead):
		print("Player won the game")
		victory_event_channel.raise_event()
