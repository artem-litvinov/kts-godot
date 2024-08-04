extends Node

const USE_MOCK_API = false

var _on_login_callback: Callable
var _on_get_world_state_callback: Callable
var _on_get_heroes_callback: Callable
var _on_generate_hero_callback: Callable
var _on_generate_event_callback: Callable


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
	var timer: Timer = Timer.new()
	timer.connect("timeout", callback)
	timer.one_shot = true
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

	var user_json = json_obj.get("user", {})

	var user = User.from_json(user_json)
	if user == null:
		parse_err = ERR_PARSE_ERROR
	_on_login_callback.call(user, parse_err)


func get_world_state(user_id: String, callback: Callable) -> Error:
	_on_get_world_state_callback = callback

	if USE_MOCK_API:
		return _make_mock_http_request(_on_get_world_state_completed_mock)
	else:
		return _make_http_request(
			Constants.GET_WORLD_STATE_ENDPOINT_ADDR,
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

	var world_json = json_obj["world"]

	var world_state = WorldState.from_json(world_json)
	if world_state == null:
		parse_err = ERR_PARSE_ERROR
	_on_get_world_state_callback.call(world_state, parse_err)


func _on_get_world_state_completed_mock():
	_on_get_world_state_callback.call(Mocks.mock_world_state, OK)


func get_heroes(user_id: String, callback: Callable) -> Error:
	_on_get_heroes_callback = callback

	if USE_MOCK_API:
		return _make_mock_http_request(_on_get_heroes_completed_mock)
	else:
		return _make_http_request(
			Constants.GET_HEROES_ENDPOINT_ADDR + '/?userId=' + user_id,
			_on_get_heroes_completed,
			HTTPClient.METHOD_GET,
		)


func _on_get_heroes_completed(result, response_code, headers, body):
	var parse_res = _parse_request(result, response_code, headers, body)
	var json_obj = parse_res[0]
	var parse_err = parse_res[1]
	if parse_err != OK:
		_on_get_heroes_callback.call(null, parse_err)

	var heroes: Array[Hero] = []
	for hero_json in json_obj.get("heroes", []):
		var hero = Hero.from_json(hero_json)

		if hero == null:
			parse_err = ERR_PARSE_ERROR
			_on_get_heroes_callback.call(null, parse_err)
			return

		heroes.append(hero)

	_on_get_heroes_callback.call(heroes, parse_err)


func _on_get_heroes_completed_mock():
	var username = GameState.get_user().name
	if username == "test1":
		_on_get_heroes_callback.call([], OK)
		return
	else:
		_on_get_heroes_callback.call(Mocks.mock_heroes, OK)


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
	if hero == null:
		parse_err = ERR_PARSE_ERROR
	_on_generate_hero_callback.call(hero, parse_err)


func _on_generate_hero_completed_mock():
	_on_generate_hero_callback.call(Mocks.mock_heroes.pick_random(), OK)


func generate_event(user_id: String, world: WorldState, hero: Hero, callback: Callable) -> Error:
	_on_generate_event_callback = callback
	if USE_MOCK_API:
		return _make_mock_http_request(_on_generate_event_completed_mock)
	else:
		return _make_http_request(
			Constants.GENERATE_EVENT_ENDPOINT_ADDR,
			_on_generate_event_completed,
			HTTPClient.METHOD_POST,
			JSON.stringify({
			  "userId": user_id,
			  "food": world.food,
			  "morale": world.morale,
			  "supplies": world.supplies,
			  "heroId": hero.id,
			  "currentHp": hero.current_hp,
			})
		)


func _on_generate_event_completed_mock():
	_on_generate_event_callback.call(Mocks.mock_event, OK)


func _on_generate_event_completed(result, response_code, headers, body):
	var parse_res = _parse_request(result, response_code, headers, body)
	var json_obj = parse_res[0]
	var parse_err = parse_res[1]
	if parse_err != OK:
		_on_generate_event_callback.call(null, parse_err)

	var event = Events.AIEvent.from_json(json_obj)
	if event == null:
		parse_err = ERR_PARSE_ERROR
	_on_generate_event_callback.call(event, parse_err)
