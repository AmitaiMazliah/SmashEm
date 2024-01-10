extends Effect

class_name SpawnEffect

@export var prefab: PackedScene

func execute(wielder: Agent2D):
	var spawned_object = prefab.instantiate()
	wielder.owner.add_child.call_deferred(spawned_object)
	spawned_object.position = wielder.collision_pos
	await spawned_object.ready
	if spawned_object.has_method('set_agent'):
		spawned_object.set_agent(wielder)
	wielder.add_spawn(spawned_object)
