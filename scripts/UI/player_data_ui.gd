extends Control



func _ready():
	Player.gold_changed.connect(_on_player_gold_changed)

func _on_player_gold_changed(player_gold: int):
	print("Player now has ", player_gold, " gold")
