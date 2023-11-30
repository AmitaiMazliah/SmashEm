extends Resource

class_name Effect

@export var time : Effect.EffectTime
@export var amount : int

func execute(_agent: Agent):
	printerr("Effect ", self.name, " is missing execute implementation")

enum EffectTime { OnTurnStart, OnTurnEnd, OnDeath, OnCollision }
