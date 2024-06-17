extends Node

const USE_MOCK_API = true

var _on_login_callback: Callable
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


func login(username: String, callback: Callable) -> Error:
	_on_login_callback = callback
	return _make_http_request(
		Constants.LOGIN_ENDPOINT_ADDR,
		_on_login_completed,
		HTTPClient.METHOD_POST,
		JSON.stringify({ "username": username }),
	)


func _on_login_completed(_result, response_code, _headers, body):
	print("Login request completed with response code: ", response_code)

	if response_code != 200:
		var parsed_body = JSON.parse_string(body.get_string_from_utf8())
		print("Login request failed with response code: ", response_code, parsed_body)
		_on_login_callback.call(null, FAILED)

	var json_obj = JSON.parse_string(body.get_string_from_utf8())
	var parse_err = ERR_PARSE_ERROR if json_obj == null else OK
	if parse_err != OK:
		_on_login_callback.call(null, parse_err)

	# TODO: remove once API is updated
	json_obj = json_obj.get("user", {})

	var user_id = json_obj.get("id", "")
	if user_id == "":
		_on_login_callback.call(null, ERR_PARSE_ERROR)

	var username = json_obj.get("name", "")
	if username == "":
		_on_login_callback.call(null, ERR_PARSE_ERROR)

	var user = User.new(user_id, username)
	_on_login_callback.call(user, parse_err)


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


func _on_generate_hero_completed_mock():
	var mock_heroes = [
		Hero.new(
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
		Hero.new(
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
		Hero.new(
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
