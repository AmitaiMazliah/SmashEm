extends Agent

@onready var other_agents = get_tree().get_nodes_in_group("Agents").filter(func (a): return a != self)

@export var min_think_time_in_secs = 1
@export var max_think_time_in_secs = 5

var _moved : bool = false

func _ready():
	print(other_agents.size())

func _process(delta):
	if _my_turn:
		if !_moved:
			var nearest_agent = _get_nearest_agent()
			print(self.name, " nearest target is ", nearest_agent.name)
			var direction = self.position.direction_to(nearest_agent.position)
			move(direction, 1000)
			_moved = true
		await get_tree().create_timer(5).timeout
		end_turn.emit()

func _get_nearest_agent() -> Agent:
	var min_distance
	var nearest_agent
	for other_agent in other_agents:
		var current_distance = position.distance_to(other_agent.position)
		if min_distance == null or current_distance < min_distance:
			min_distance = current_distance
			nearest_agent = other_agent
	return nearest_agent
