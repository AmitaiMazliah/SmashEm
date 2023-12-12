extends Effect

class_name DamageEffect

@export var who_to_damage: Target

func execute(agent: Agent2D):
	var targets = _get_targets(who_to_damage, agent)
	for target in targets:
		target.health.take_damage(amount)

func _get_targets(who_to_find: Target, agent: Agent2D) -> Array:
	match who_to_find:
		Target.All:
			return _get_all_live_agents(agent)
		Target.AllButMe:
			return _get_all_live_agents(agent).filter(func (a): return a != agent)
		Target.Random:
			return [_get_all_live_agents(agent).pick_random()]
		Target.RandomNotMe:
			return [_get_all_live_agents(agent).filter(func (a): return a != agent).pick_random()]
		Target.Nearest:
			return [_get_nearest_agent(agent)]
		_: return []

func _get_all_live_agents(agent: Agent2D) -> Array:
	return agent.get_tree().get_nodes_in_group("Agents").filter(func (a): return not a.dead)

func _get_nearest_agent(agent: Agent2D) -> Agent2D:
	var min_distance
	var nearest_agent
	var other_agents = _get_all_live_agents(agent).filter(func (a): return a != agent)
	for other_agent in other_agents:
		var current_distance = agent.position.distance_to(other_agent.position)
		if min_distance == null or current_distance < min_distance:
			min_distance = current_distance
			nearest_agent = other_agent
	return nearest_agent

enum Target
{
	All,
	AllButMe,
	Random,
	RandomNotMe,
	Nearest
}
