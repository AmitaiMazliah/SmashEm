extends Control

@onready var _gold_label: Label = $MarginContainer/HBoxContainer/GoldPanel/Label

func _ready():
	Player.gold_changed.connect(_on_player_gold_changed)
	_gold_label.text = str(Player.gold)

func _on_player_gold_changed(player_gold: int):
	_gold_label.text = str(player_gold)
	print("Player now has ", player_gold, " gold")
