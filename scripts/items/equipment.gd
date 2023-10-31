extends Resource

class_name Equipment

@export var slot : Slot
@export var bonus_health : int
@export var bonus_damage : int
@export var effects : Array[Effect]

enum Slot { Head, Chest, Boots, Weapon }
