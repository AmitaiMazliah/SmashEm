extends Panel

@export var equipment_slot: Equipment.Slot

func _can_drop_data(_pos, data):
	var player_equipment = data as PlayerEquipment
	return player_equipment.equipment.slot == equipment_slot
 
func _drop_data(_pos, data):
	var player_equipment = data as PlayerEquipment
	Player.change_selected_item(player_equipment)
