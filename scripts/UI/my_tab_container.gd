extends TabContainer

func _ready():
	_change_tab(1)

func _on_play_button_pressed():
	_change_tab(1)

func _on_items_button_pressed():
	_change_tab(2)

func _on_shop_button_pressed():
	_change_tab(0)

func _change_tab(index: int):
	var current_tab_control = get_current_tab_control()
	if current_tab_control.has_method("on_close"):
		current_tab_control.on_close()
		
	current_tab = index
	current_tab_control = get_current_tab_control()
	if current_tab_control.has_method("on_open"):
		current_tab_control.on_open()
