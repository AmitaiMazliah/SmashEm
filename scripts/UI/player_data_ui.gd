extends Control

@onready var _trophy_count_label: Label = $MarginContainer/HBoxContainer/TrophyPanel/Label
@onready var _gold_label: Label = $MarginContainer/HBoxContainer/GoldPanel/Label

func _ready():
	Player.trophy_count_changed.connect(_on_trophy_count_changed)
	Player.gold_changed.connect(_on_player_gold_changed)
	_on_trophy_count_changed(Player.trophy_count)
	_on_player_gold_changed(Player.gold)

func _on_player_gold_changed(player_gold: int):
	_gold_label.text = str(player_gold)
	print("Player now has ", player_gold, " gold")

func _on_trophy_count_changed(trophy_count: int):
	_trophy_count_label.text = str(trophy_count)
	print("Player now has ", trophy_count, " trophies")
