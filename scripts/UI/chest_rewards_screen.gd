extends CanvasLayer

class_name ChestRewardsScreen

@onready var _reward_name_label: Label = $RewardArea/MarginContainer/HBoxContainer/RewardName
@onready var _reward_amount_label: Label = $RewardArea/MarginContainer/HBoxContainer/Panel/RewardAmount
@onready var _reward_icon: TextureRect = $RewardArea/MarginContainer/HBoxContainer/Panel/RewardIcon

@export var _items_catalog: ItemsCatalog

var _chest_rewards: Array[ChestReward]
var _current_reward_index: int

func set_chest(chest: Chest):
	_chest_rewards = _draw_chest_rewards(chest)
	show()
	_current_reward_index = -1
	_show_next_reward()

func _draw_chest_rewards(chest: Chest) -> Array[ChestReward]:
	var rewards = [] as Array[ChestReward]
	var given_gold = randi_range(chest.min_gold, chest.max_gold)
	rewards.append(ChestReward.new("Gold", given_gold, null))
	var duplicated_items_catalog = _items_catalog.equipment
	randomize()
	duplicated_items_catalog.shuffle()
	var given_cards_amount = 0
	for i in chest.different_cards:
		var amount
		if i == chest.different_cards - 1:
			amount = chest.cards_amount - given_cards_amount
		else:
			amount = randi_range(1, chest.cards_amount - chest.different_cards + (i + 1) - given_cards_amount)
		given_cards_amount += amount
		var card = duplicated_items_catalog[i]
		rewards.append(ChestReward.new(card.name, amount, card.sprite))
	rewards.sort_custom(func (a, b): return a.amount > b.amount)
	return rewards

func _show_next_reward():
	_current_reward_index += 1
	if _current_reward_index >= len(_chest_rewards):
		hide()
	else:
		var reward = _chest_rewards[_current_reward_index]
		_reward_name_label.text = reward.name
		_reward_amount_label.text = "+" + str(reward.amount)

func _on_next_reward_button_pressed():
	_show_next_reward()

class ChestReward:
	var name: String
	var amount: int
	var icon: Texture
	
	func _init(_name: String, _amount: int, _icon: Texture):
		name = _name
		amount = _amount
		icon = _icon
