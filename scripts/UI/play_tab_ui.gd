extends Control

@export var load_scene_event_channel: LoadSceneEventChannel
@export var game_scene: GameScene

@onready var _settings_panel: SettingsPanel = $MarginContainer/Control/SettingsArea
@onready var _chests_area: ChestArea = $MarginContainer/Control/ChestsArea
@onready var _chest_dialog: UnlockChestDialog = $MarginContainer/Control/ChestDialog
@onready var _chest_rewards_screen: ChestRewardsScreen = $MarginContainer/Control/ChestRewardsScreen

func _ready():
	_settings_panel.hide()
	_chests_area.chest_selected.connect(_on_chest_selected)
	_chests_area.set_chests(Player.chests)

func on_close():
	_settings_panel.hide()

func _on_play_button_pressed():
	load_scene_event_channel.raise_event(game_scene, false)

func _on_settings_button_pressed():
	_settings_panel.show()

func _on_chest_selected(player_chest: PlayerChest):
	if player_chest.locked:
		_chest_dialog.set_chest(player_chest, Player.chests.filter(func (c): return c).all(func (c): return not c.started_open))
		_chest_dialog.show()
	else:
		_chest_rewards_screen.set_chest(player_chest.chest)
		_chest_rewards_screen.show()
