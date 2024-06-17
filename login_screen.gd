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


func _on_login_completed(user: User, error: Error):
	if error != OK:
		print("Failed to login: ", error)
		return

	GameState.initialise_user(user)

	SceneManager.goto_village()
