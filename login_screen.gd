extends Control


func _ready() -> void:
	%UsernameInput.grab_focus()


func _on_username_input_text_submitted(new_text: String) -> void:
	login(new_text)


func _on_login_button_pressed() -> void:
	login(%UsernameInput.text)


func login(username: String) -> void:
	%LoginContainer.hide()
	%LoadingContainer.show()
	var error = BackendAPI.login(username, _on_login_completed)
	if error != OK:
		print("Failed to login: ", error)


func _on_login_completed(user: User, error: Error):
	if error != OK:
		print("Failed to login: ", error)
		%LoadingContainer.hide()
		%LoginContainer.show()
		return

	%ProgressBar.value = 33
	GameState.initialise_user(user)
	BackendAPI.get_world_state(user.id, _on_get_world_state_completed)


func _on_get_world_state_completed(world_state: WorldState, error: Error):
	if error != OK:
		print("Failed to get world state: ", error)
		%LoadingContainer.hide()
		%LoginContainer.show()
		return

	%ProgressBar.value = 66
	GameState.initialise_world_state(world_state)

	BackendAPI.get_heroes(GameState.user.id, _on_get_heroes_completed)


func _on_get_heroes_completed(heroes: Array[Hero], error: Error):
	if error != OK:
		print("Failed to get heroes: ", error)
		%LoadingContainer.hide()
		%LoginContainer.show()
		return

	%ProgressBar.value = 100
	GameState.initialise_heroes(heroes)

	SceneManager.goto_village()
