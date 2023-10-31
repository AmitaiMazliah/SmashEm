extends Node

class_name AgentEquipment

@export var current_equipment : Dictionary

func execute_all_effect_for_time(agent: Agent, effect_time: Constants.EffectTime):
	for i in current_equipment:
		var equipment : Equipment = current_equipment[i]
		for effect in equipment.effects:
			if effect.time == effect_time:
				effect.execute(agent)
