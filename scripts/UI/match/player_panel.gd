extends Panel

class_name AgentPanel

signal pressed
signal released

var agent: Agent2D

func set_agent(agent: Agent2D):
	self.agent = agent

func _gui_input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		if event.pressed:
			pressed.emit()
		else:
			released.emit()
