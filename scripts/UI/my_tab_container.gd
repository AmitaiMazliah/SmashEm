extends TabContainer

func _ready():
	current_tab = 1

func _on_play_button_pressed():
	current_tab = 1

func _on_items_button_pressed():
	current_tab = 2

func _on_shop_button_pressed():
	current_tab = 0
