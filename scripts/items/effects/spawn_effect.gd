extends Effect

class_name SpawnEffect

@export var prefab: PackedScene

func execute(wielder: Agent2D):
	var spawned_object = prefab.instantiate()
	wielder.get_tree().root.add_child(spawned_object)
	spawned_object.position = wielder.collision_pos
	await spawned_object.ready
