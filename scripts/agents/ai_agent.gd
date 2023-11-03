extends Agent

@onready var other_agents = get_tree().get_nodes_in_group("Agents").filter(func (a): return a != self)

@export var min_think_time_in_secs = 1
@export var max_think_time_in_secs = 5

var _played_turn : bool = false

func _ready():
	super._ready()
	print(other_agents.size())

func _process(delta):
	if _my_turn:
		if !_played_turn:
			var nearest_agent = _get_nearest_agent()
			print(self.name, " nearest target is ", nearest_agent.name)
			var direction = self.position.direction_to(nearest_agent.position)
			move(direction)
			_played_turn = true

func _get_nearest_agent() -> Agent:
	var min_distance
	var nearest_agent
	for other_agent in other_agents:
		var current_distance = position.distance_to(other_agent.position)
		if min_distance == null or current_distance < min_distance:
			min_distance = current_distance
			nearest_agent = other_agent
	return nearest_agent

func _on_sleeping_state_changed():
	print(self.name, " is now sleeping=", sleeping)
	if _my_turn and sleeping:
		print(self.name, " went sleeping, ending turn")
		end_turn()

func end_turn():
	_played_turn = false
	super.end_turn()
