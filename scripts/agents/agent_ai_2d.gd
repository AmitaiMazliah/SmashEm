extends Node

class_name AgentAI3D

@export var min_think_time_in_secs: float = 1
@export var max_think_time_in_secs: float = 5
@export_range(0, 1, 0.01) var chance_to_have_item: float = 0.25
@export var item_catalog: ItemsCatalog

@onready var agent: Agent2D = self.get_parent()

var _played_turn: bool

func _ready():
	agent.turn_ended.connect(_on_agent_turn_ended)
	var equipment := {}
	for slot in Equipment.Slot.values():
		randomize()
		var randomNumber = randi() % 100
		if randomNumber <= (chance_to_have_item * 100):
			equipment[slot] = item_catalog.equipment.filter(func (e): return e.slot == slot).pick_random()
	agent.set_equipment(equipment)

func _process(_delta):
	if agent.is_my_turn and not _played_turn:
		_played_turn = true
		randomize()
		var random_wait_time = randf_range(min_think_time_in_secs, max_think_time_in_secs)
		print(agent.name, " will wait ", random_wait_time, " secs before playing")
		get_tree().create_timer(random_wait_time).timeout.connect(_play_turn)

func _play_turn():
	var nearest_agent = _get_nearest_agent()
	print(agent.name, " nearest target is ", nearest_agent.name)
	var direction = agent.position.direction_to(nearest_agent.position)
	agent.move(direction)

func _get_nearest_agent() -> Agent2D:
	var other_agents = get_tree().get_nodes_in_group("Agents").filter(func (a): return a != agent)
	other_agents.sort_custom(func (a, b): return agent.position.distance_to(a.position) < agent.position.distance_to(b.position))
	return other_agents.front()

func _on_agent_turn_ended():
	_played_turn = false
