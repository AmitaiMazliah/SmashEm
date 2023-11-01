extends Agent

@onready var other_agents = get_tree().get_nodes_in_group("Agents").filter(func (a): return a != self)

func _ready():
	print(other_agents.size())

func _process(delta):
	if _my_turn:
		var min_distance
		var nearest_agent
		for other_agent in other_agents:
			var current_distance = position.distance_to(other_agent.position)
			if min_distance == null or current_distance < min_distance:
				min_distance = current_distance
				nearest_agent = other_agent
		print(self.name, " nearest target is ", nearest_agent.name)
