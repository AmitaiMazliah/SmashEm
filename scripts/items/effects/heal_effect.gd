extends Effect

class_name HealEffect

func execute(agent: Agent2D):
	agent.health.heal(amount)
