class_name MyPlayFab

static func send_request(body: Dictionary, path: String, auth_type, additional_headers: Dictionary = {}) -> Promise:
	return Promise.new(
		func(resolve: Callable, reject: Callable):
			PlayFabManager.client.post_dict_auth(body, path, auth_type, resolve, reject, additional_headers)
	)
