extends Resource

class_name Equipment

@export var name: String
@export_multiline var description: String
@export var sprite: Texture
@export var prefab: PackedScene

@export var slot : Slot
@export var bonus_health : int
@export var bonus_damage : int
@export var effects : Array[Effect]

enum Slot { Head, RightHand, LeftHand, Boots }
