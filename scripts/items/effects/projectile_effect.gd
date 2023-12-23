extends Effect

class_name ProjectileEffect

@export var projectile_prefab: PackedScene

func execute(wielder: Agent2D):
	var nearest_agent = _get_nearest_agent(wielder)
	var projectile: Projectile = projectile_prefab.instantiate() as Projectile
	wielder.add_child(projectile)
	projectile.position = Vector2.ZERO
	projectile.fire(wielder, wielder.global_position.direction_to(nearest_agent.position), 5)
	await projectile.destroyed

func _get_nearest_agent(agent: Agent2D) -> Agent2D:
	var other_agents = agent.get_tree().get_nodes_in_group("Agents").filter(func (a): return a != agent)
	other_agents.sort_custom(func (a, b): return agent.position.distance_to(a.position) < agent.position.distance_to(b.position))
	return other_agents.front()
