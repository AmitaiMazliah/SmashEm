extends Effect

class_name HealEffect

func execute(agent: Agent):
	agent.heal(amount)
