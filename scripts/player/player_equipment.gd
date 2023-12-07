class_name PlayerEquipment

var equipment: Equipment
var level: int
var amount: int
var amount_to_upgrade: int :
	get:
		return EquipmentData.amount_per_level.get(level + 1)

func _init(_equipment: Equipment, _level: int, _amount: int):
	self.equipment = _equipment
	self.level = _level
	self.amount = _amount

func can_upgrade() -> bool:
	return amount >= amount_to_upgrade
