extends Control


func _ready() -> void:
	%UsernameInput.grab_focus()


func _on_username_input_text_submitted(new_text: String) -> void:
	login(new_text)


func _on_login_button_pressed() -> void:
	login(%UsernameInput.text)


func login(username: String) -> void:
	var error = BackendAPI.login(username, _on_login_completed)
	if error != OK:
		print("Failed to login: ", error)


func _on_login_completed(result: Dictionary, error: Error):
	if error != OK:
		print("Failed to login: ", error)
		return

	var user_obj = result.get("user")
	GameState.initialise_user(user_obj.get("id"), user_obj.get("name"))

	var world_obj = result.get("world")
	GameState.initialise_world(world_obj.get("food"), world_obj.get("morale"), world_obj.get("supplies"))

	SceneManager.goto_village()
