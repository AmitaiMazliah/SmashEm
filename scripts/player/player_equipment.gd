class_name PlayerEquipment

var equipment: Equipment
var level: int
var amount: int

func _init(equipment: Equipment, level: int, amount: int):
	self.equipment = equipment
	self.level = level
	self.amount = amount

func can_upgrade() -> bool:
	var amount_to_upgrade = EquipmentData.amount_per_level.get(level + 1)
	return amount >= amount_to_upgrade
