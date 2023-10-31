extends Resource

class_name Effect

@export var time : Constants.EffectTime
@export var amount : int

func execute(agent: Agent):
	print("Effect ", self.name, " is missing execute implementation")
