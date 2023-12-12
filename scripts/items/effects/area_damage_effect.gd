extends Effect

class_name AreaDamageEffect

@export var radius: float

func execute(agent: Agent2D):
	var targets = _get_targets(agent)
	for target in targets:
		target.health.take_damage(amount)

func _get_targets(agent: Agent2D) -> Array:
	var shape_rid = PhysicsServer2D.circle_shape_create()
	PhysicsServer2D.shape_set_data(shape_rid, radius)
	
	var params = PhysicsShapeQueryParameters2D.new()
	params.shape_rid = shape_rid
	#params.transform = Transform2D(0, agent.position)  # set position/rotation/scale of shape
	
	# Execute physics queries here...
	var collisions = agent.get_world_2d().direct_space_state.intersect_shape(params)
	var agents = collisions.map(func (collision_info): return collision_info.collider) \
		.filter(func (c): return c is Agent3D) \
		.filter(func (a): return not a.dead) \
		.filter(func (a): return a != agent)
	
	# Release the shape when done with physics queries.
	PhysicsServer2D.free_rid(shape_rid)
	
	return agents
