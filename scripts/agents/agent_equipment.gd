extends Node

class_name AgentEquipment

@export var current_equipment : Dictionary
@export var _head_place_holder: Node2D
@export var _right_hand_place_holder: Node2D
@export var _left_hand_place_holder: Node2D
@export var _legs_place_holder: Node2D

func _ready():
	for i in current_equipment:
		var equipment : Equipment = current_equipment[i]
		var equipment_instance = equipment.prefab.instantiate()
		match equipment.slot:
			Equipment.Slot.Head:
				_head_place_holder.add_child(equipment_instance)
			Equipment.Slot.RightHand:
				_right_hand_place_holder.add_child(equipment_instance)
			Equipment.Slot.LeftHand:
				_left_hand_place_holder.add_child(equipment_instance)
			Equipment.Slot.Boots:
				_legs_place_holder.add_child(equipment_instance)

func execute_all_effect_for_time(agent: Agent, effect_time: Effect.EffectTime):
	for i in current_equipment:
		var equipment : Equipment = current_equipment[i]
		for effect in equipment.effects:
			if effect.time == effect_time:
				effect.execute(agent)

func get_total_health_bonus() -> int:
	var health_bonus = 0
	for i in current_equipment:
		health_bonus += current_equipment[i].bonus_health
	return health_bonus

func get_total_damage_bonus() -> int:
	var damage_bonus = 0
	for i in current_equipment:
		damage_bonus += current_equipment[i].bonus_damage
	return damage_bonus
