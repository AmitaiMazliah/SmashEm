extends Resource

class_name Effect

@export var time : Effect.EffectTime
@export var amount : int

enum EffectTime { OnTurnStart, OnTurnEnd, OnDeath, OnCollision }
