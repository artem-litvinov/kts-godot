extends Node

const USE_MOCK_API = false

var _on_get_user_data_callback: Callable
var _on_get_world_state_callback: Callable
var _on_get_heroes_callback: Callable
var _on_generate_hero_callback: Callable
var _on_generate_event_callback: Callable
var _on_chat_with_hero_callback: Callable


func _make_http_request(
	url: String,
	callback: Callable,
	method: HTTPClient.Method = HTTPClient.METHOD_GET,
	body: String = "",
) -> Error:
	var http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.request_completed.connect(callback)
	
	var headers = ["Authorization: Bearer %s" % Firebase.Auth.auth.idtoken]
	if method == HTTPClient.METHOD_POST:
		headers.append("Content-Type: application/json")
	
	print("Making HTTP request:")  # Debug prints
	print("- URL: ", url)
	print("- Method: ", method)
	print("- Headers: ", headers)
	print("- Body: ", body)
	
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

func get_user_data(callback: Callable) -> Error:
	_on_get_user_data_callback = callback
	return _make_http_request(
		Constants.GET_USER_DATA_ENDPOINT_ADDR,
		_on_get_user_data_completed,
	)

func _on_get_user_data_completed(result, response_code, headers, body):
	var parse_res = _parse_request(result, response_code, headers, body)
	var json_obj = parse_res[0]
	var parse_err = parse_res[1]
	if parse_err != OK:
		_on_get_user_data_callback.call(null, parse_err)

	var user = User.from_json(json_obj)
	if user == null:
		parse_err = ERR_PARSE_ERROR
	_on_get_user_data_callback.call(user, parse_err)


func get_world_state(callback: Callable) -> Error:
	_on_get_world_state_callback = callback

	if USE_MOCK_API:
		return _make_mock_http_request(_on_get_world_state_completed_mock)
	else:
		return _make_http_request(
			Constants.GET_WORLD_STATE_ENDPOINT_ADDR,
			_on_get_world_state_completed,
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


func get_heroes(callback: Callable) -> Error:
	_on_get_heroes_callback = callback

	if USE_MOCK_API:
		return _make_mock_http_request(_on_get_heroes_completed_mock)
	else:
		return _make_http_request(
			Constants.GET_HEROES_ENDPOINT_ADDR,
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


func generate_hero(callback: Callable) -> Error:
	_on_generate_hero_callback = callback

	if USE_MOCK_API:
		return _make_mock_http_request(_on_generate_hero_completed_mock)
	else:
		return _make_http_request(
			Constants.GENERATE_HERO_ENDPOINT_ADDR,
			_on_generate_hero_completed,
		)


func _on_generate_hero_completed(result, response_code, headers, body):
	var parse_res = _parse_request(result, response_code, headers, body)
	var json_obj = parse_res[0]
	var parse_err = parse_res[1]
	if parse_err != OK:
		_on_generate_hero_callback.call(null, parse_err)

	var hero_json = json_obj["hero"]

	var hero = Hero.from_json(hero_json)
	if hero == null:
		parse_err = ERR_PARSE_ERROR
	_on_generate_hero_callback.call(hero, parse_err)


func _on_generate_hero_completed_mock():
	_on_generate_hero_callback.call(Mocks.mock_heroes.pick_random(), OK)


func generate_event(world: WorldState, hero: Hero, callback: Callable) -> Error:
	_on_generate_event_callback = callback
	if USE_MOCK_API:
		return _make_mock_http_request(_on_generate_event_completed_mock)
	else:
		var body: Dictionary = {
		  "supplies": world.supplies,
		}
		if hero:
			body.heroId = hero.id
			body.currentHp = hero.current_hp

		return _make_http_request(
			Constants.GENERATE_EVENT_ENDPOINT_ADDR,
			_on_generate_event_completed,
			HTTPClient.METHOD_POST,
			JSON.stringify(body)
		)


func _on_generate_event_completed_mock():
	_on_generate_event_callback.call(Mocks.mock_event, OK)


func _on_generate_event_completed(result, response_code, headers, body):
	var parse_res = _parse_request(result, response_code, headers, body)
	var json_obj = parse_res[0]
	var parse_err = parse_res[1]
	if parse_err != OK:
		_on_generate_event_callback.call(null, parse_err)
		return

	var event = Events.AIEvent.from_json(json_obj)
	if event == null:
		parse_err = ERR_PARSE_ERROR
	_on_generate_event_callback.call(event, parse_err)


func chat_with_hero(hero_id: String, message: String, callback: Callable) -> Error:
	_on_chat_with_hero_callback = callback
	
	if USE_MOCK_API:
		return _make_mock_http_request(_on_chat_with_hero_completed_mock)
	
	var trimmed_hero_id = hero_id.strip_edges()
	var trimmed_message = message.strip_edges()
	
	if trimmed_hero_id.is_empty() or trimmed_message.is_empty():
		_on_chat_with_hero_callback.call(null, ERR_INVALID_DATA)
		return ERR_INVALID_DATA
	
	var body_dict = {
		"heroId": trimmed_hero_id,
		"message": trimmed_message
	}
	
	return _make_http_request(
		Constants.CHAT_WITH_HERO_ENDPOINT_ADDR,
		_on_chat_with_hero_completed,
		HTTPClient.METHOD_POST,
		JSON.stringify(body_dict)
	)

func _on_chat_with_hero_completed(result, response_code, _headers, body):
	if result != OK or response_code != 200:
		_on_chat_with_hero_callback.call(null, ERR_INVALID_DATA)
		return
	
	var json = JSON.new()
	var parse_err = json.parse(body.get_string_from_utf8())
	if parse_err != OK:
		_on_chat_with_hero_callback.call(null, parse_err)
		return
		
	var response = json.get_data()
	if not response is Dictionary:
		_on_chat_with_hero_callback.call(null, ERR_INVALID_DATA)
		return
		
	var message = response.get("response", response.get("message", null))
	if message == null:
		_on_chat_with_hero_callback.call(null, ERR_INVALID_DATA)
		return
		
	_on_chat_with_hero_callback.call(str(message), OK)

func _on_chat_with_hero_completed_mock():
	_on_chat_with_hero_callback.call("This is a mock response from the hero!", OK)
