extends Node

class_name MatchManager

var players = []
var turn : int = 0

func change_turn():
	var current_player = players[turn]
	turn += 1
	if (turn == players.count):
		turn = 0
	print("turn ", turn, " current player ", current_player)
	pass
	
func _on_player_connected(peer_id, player_info):
	print("Player id ", peer_id, " joined")
	players.append(player_info)
