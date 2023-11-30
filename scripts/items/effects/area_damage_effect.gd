extends Effect

class_name AreaDamageEffect

@export var radius: float

var _shape_cast: ShapeCast2D

func init(agent: Agent):
	_shape_cast = ShapeCast2D.new()
	_shape_cast.collide_with_areas=true
	_shape_cast.target_position = Vector2.ZERO
	_shape_cast.shape = CircleShape2D.new()
	_shape_cast.shape.radius = radius
	agent.add_child(_shape_cast)

func execute(agent: Agent):
	var targets = _get_targets(agent)
	for target in targets:
		target.health.take_damage(amount)

func _get_targets(agent: Agent) -> Array:
	var collisions = _shape_cast.collision_result
	var agents = collisions.map(func (collision_info): return collision_info.collider).filter(func (c): return c is Agent)
	var live_agents = agents.filter(func (a): return not a.dead)
	return live_agents
