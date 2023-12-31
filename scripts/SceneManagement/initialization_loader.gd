extends Node

@export var load_scene_event_channel: LoadSceneEventChannel
@export var main_menu_scene: GameScene
@export var _save_system: SaveSystem
@export var items_catalog: ItemsCatalog

func _ready():
	_save_system.load()
	PlayFabManager.client.logged_in.connect(_on_logged_in)
	PlayFabManager.client.api_error.connect(_on_api_error)
	_login()

func _on_logged_in(_login_result: LoginResult):
	print("Logged in successfully")
	await items_catalog.init()
	await Player.init(items_catalog)
	load_scene_event_channel.raise_event(main_menu_scene, true)

func _on_api_error(_api_error_wrapper: ApiErrorWrapper):
	print("error")

func _login():
	print(OS.get_name())
	match OS.get_name():
		"Windows", "Web", "macOS", "Android":
			var combined_info_request_params = GetPlayerCombinedInfoRequestParams.new()
			combined_info_request_params.show_all()
			var player_profile_view_constraints = PlayerProfileViewConstraints.new()
			combined_info_request_params.ProfileConstraints = player_profile_view_constraints
			var tags = {}
			PlayFabManager.client.login_with_email("a@gmail.com", "password", tags, combined_info_request_params)


