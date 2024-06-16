extends Node

var _on_login_callback: Callable


func login(username: String, callback: Callable) -> Error:
	var login_http_request = HTTPRequest.new()
	add_child(login_http_request)

	login_http_request.connect("request_completed", _on_login_completed)
	_on_login_callback = callback

	return login_http_request.request(Constants.LOGIN_ENDPOINT_ADDR + username)


func _on_login_completed(_result, response_code, _headers, body):
	print("Login request completed with response code: ", response_code)

	if response_code != 200:
		print("Login request failed with response code: ", response_code)
		return FAILED

	var json_obj = JSON.parse_string(body.get_string_from_utf8())
	var parse_err = ERR_PARSE_ERROR if json_obj == null else OK
	_on_login_callback.call(json_obj, parse_err)
