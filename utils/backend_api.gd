extends Node

const USE_MOCK_API = true

var _on_login_callback: Callable
var _on_get_world_state_callback: Callable
var _on_generate_hero_callback: Callable


func _make_http_request(
	url: String,
	callback: Callable,
	method: HTTPClient.Method = HTTPClient.METHOD_GET,
	body: String = "",
) -> Error:
	var http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.connect("request_completed", callback)

	var headers = []
	if method == HTTPClient.METHOD_POST:
		headers.append("Content-Type: application/json")
	return http_request.request(url, headers, method, body)


func _make_mock_http_request(callback: Callable) -> Error:
	var timer = Timer.new()
	timer.connect("timeout", callback)
	timer.wait_time = 1.0
	get_tree().root.add_child(timer)
	timer.start()
	return OK


func _parse_request(_result, response_code, _headers, body) -> Array:
	print("Request completed with response code: ", response_code)

	if response_code != 200:
		var parsed_body = JSON.parse_string(body.get_string_from_utf8())
		print("Request failed with response code: ", response_code, parsed_body)
		return [null, FAILED]

	var json_obj = JSON.parse_string(body.get_string_from_utf8())
	var parse_err = ERR_PARSE_ERROR if json_obj == null else OK
	return [json_obj, parse_err]


func login(username: String, callback: Callable) -> Error:
	_on_login_callback = callback
	return _make_http_request(
		Constants.LOGIN_ENDPOINT_ADDR,
		_on_login_completed,
		HTTPClient.METHOD_POST,
		JSON.stringify({ "username": username }),
	)


func _on_login_completed(result, response_code, headers, body):
	var parse_res = _parse_request(result, response_code, headers, body)
	var json_obj = parse_res[0]
	var parse_err = parse_res[1]
	if parse_err != OK:
		_on_login_callback.call(null, parse_err)

	# TODO: remove once API is updated
	json_obj = json_obj.get("user", {})

	var user = User.from_json(json_obj)
	_on_login_callback.call(user, parse_err)


func get_world_state(user_id: String, callback: Callable) -> Error:
	_on_get_world_state_callback = callback

	if USE_MOCK_API:
		return _make_mock_http_request(_on_get_world_state_completed_mock)
	else:
		return _make_http_request(
			Constants.GENERATE_HERO_ENDPOINT_ADDR,
			_on_get_world_state_completed,
			HTTPClient.METHOD_POST,
			JSON.stringify({ "userId": user_id }),
		)


func _on_get_world_state_completed(result, response_code, headers, body):
	var parse_res = _parse_request(result, response_code, headers, body)
	var json_obj = parse_res[0]
	var parse_err = parse_res[1]
	if parse_err != OK:
		_on_get_world_state_callback.call(null, parse_err)

	var world_state = WorldState.from_json(json_obj)
	_on_get_world_state_callback.call(world_state, parse_err)


func _on_get_world_state_completed_mock():
	var world_state = WorldState.from_params(20, 50, 100)
	_on_get_world_state_callback.call(world_state, OK)


func generate_hero(user_id: String, callback: Callable) -> Error:
	_on_generate_hero_callback = callback

	if USE_MOCK_API:
		return _make_mock_http_request(_on_generate_hero_completed_mock)
	else:
		return _make_http_request(
			Constants.GENERATE_HERO_ENDPOINT_ADDR,
			_on_generate_hero_completed_mock,
			HTTPClient.METHOD_POST,
			JSON.stringify({ "userId": user_id }),
		)

func _on_generate_hero_completed(result, response_code, headers, body):
	var parse_res = _parse_request(result, response_code, headers, body)
	var json_obj = parse_res[0]
	var parse_err = parse_res[1]
	if parse_err != OK:
		_on_generate_hero_callback.call(null, parse_err)

	var hero = Hero.from_json(json_obj)
	_on_generate_hero_callback.call(hero, parse_err)

func _on_generate_hero_completed_mock():
	var mock_heroes = [
		Hero.from_params(
			"1",
			"Ben",
			Enums.Gender.MALE,
			Enums.HeroType.FIGHTER,
			Enums.HeroTier.S,
			"Ben description",
			"villager_1",
			100,
			200,
			200
		),
		Hero.from_params(
			"2",
			"Alice",
			Enums.Gender.MALE,
			Enums.HeroType.ASSASIN,
			Enums.HeroTier.A,
			"Alice description",
			"villager_2",
			100,
			200,
			200
		),
		Hero.from_params(
			"3",
			"Bob",
			Enums.Gender.MALE,
			Enums.HeroType.MAGE,
			Enums.HeroTier.B,
			"Bob description",
			"villager_3",
			100,
			200,
			200
		),
	]
	_on_generate_hero_callback.call(mock_heroes.pick_random(), OK)
