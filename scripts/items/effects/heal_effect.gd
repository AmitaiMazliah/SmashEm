extends Effect

class_name HealEffect

func execute(agent: Agent3D):
	agent.health.heal(amount)
