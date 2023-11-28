extends CanvasLayer

class_name ChestRewardsScreen

@onready var _reward_amount_label: Label = $RewardArea/Panel/RewardAmount

var _chest: Chest

func set_chest(chest: Chest):
	_chest = chest
	var given_gold = randi_range(chest.min_gold, chest.max_gold)
	_reward_amount_label.text = "+" + str(given_gold)
	print("Chest will give ", given_gold, " gold")

func _on_next_reward_button_pressed():
	hide()
