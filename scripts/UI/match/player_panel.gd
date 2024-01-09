extends Panel

class_name AgentPanel

signal pressed
signal released

@onready var disabled_icon: TextureRect = $DisabledIcon

var agent: Agent2D
var disabled: bool :
	set (value):
		disabled = value
		disabled_icon.visible = disabled
	get:
		return disabled

func set_agent(agent: Agent2D):
	self.agent = agent

func _gui_input(event: InputEvent) -> void:
	if disabled:
		return
	
	if event is InputEventScreenTouch:
		if event.pressed:
			pressed.emit()
		else:
			released.emit()
