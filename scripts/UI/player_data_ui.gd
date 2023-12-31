extends Control

@onready var _trophy_count_label: Label = $MarginContainer/HBoxContainer/TrophyPanel/Label
@onready var _gold_label: Label = $MarginContainer/HBoxContainer/GoldPanel/Label
@onready var _crystals_label: Label = $MarginContainer/HBoxContainer/CrystalsPanel/Label

func _ready():
	Player.trophy_count.value_changed.connect(_on_trophy_count_changed)
	Player.gold.value_changed.connect(_on_player_gold_changed)
	Player.crystals.value_changed.connect(_on_player_crystals_changed)
	_on_trophy_count_changed(Player.trophy_count.value)
	_on_player_gold_changed(Player.gold.value)
	_on_player_crystals_changed(Player.crystals.value)

func _on_trophy_count_changed(trophy_count: int):
	_trophy_count_label.text = str(trophy_count)
	print("Player now has ", trophy_count, " trophies")

func _on_player_gold_changed(player_gold: int):
	_gold_label.text = str(player_gold)
	print("Player now has ", player_gold, " gold")

func _on_player_crystals_changed(player_crystals: int):
	_crystals_label.text = str(player_crystals)
	print("Player now has ", player_crystals, " crystals")
