extends Control


func _ready() -> void:
	# Initialize Firebase signals for handling login and signup
	Firebase.Auth.login_succeeded.connect(_on_login_succeeded)
	Firebase.Auth.signup_succeeded.connect(_on_login_succeeded)
	Firebase.Auth.login_failed.connect(_on_login_failed)
	Firebase.Auth.signup_failed.connect(_on_signup_failed)
	%EmailInput.grab_focus()


func _on_input_text_submitted(_text: String) -> void:
	Firebase.Auth.login_with_email_and_password(%EmailInput.text, %PasswordInput.text)


func _on_login_button_pressed() -> void:
	Firebase.Auth.login_with_email_and_password(%EmailInput.text, %PasswordInput.text)
	%LoginContainer.hide()
	%LoadingContainer.show()
	
	
func _on_register_button_pressed() -> void:
	Firebase.Auth.signup_with_email_and_password(%EmailInput.text, %PasswordInput.text)
	%LoginContainer.hide()
	%LoadingContainer.show()
	
	
func _on_login_succeeded(auth) -> void:
	print(auth)
	%ProgressBar.value = 25
	BackendAPI.get_user_data(_on_get_user_data_completed)
	
	
func _on_get_user_data_completed(user: User, error: Error):
	if error != OK:
		print("Failed to login: ", error)
		%LoadingContainer.hide()
		%LoginContainer.show()
		return

	%ProgressBar.value = 50
	GameState.initialize_user(user)
	
	BackendAPI.get_world_state(_on_get_world_state_completed)
	
	
func _on_get_world_state_completed(world_state: WorldState, error: Error):
	if error != OK:
		print("Failed to get world state: ", error)
		%LoadingContainer.hide()
		%LoginContainer.show()
		return

	%ProgressBar.value = 75
	GameState.initialize_world_state(world_state)

	BackendAPI.get_heroes(_on_get_heroes_completed)


func _on_get_heroes_completed(heroes: Array[Hero], error: Error):
	if error != OK:
		print("Failed to get heroes: ", error)
		%LoadingContainer.hide()
		%LoginContainer.show()
		return

	%ProgressBar.value = 100
	GameState.initialize_heroes(heroes)

	SceneManager.goto_village()
	
	
func _on_login_failed(error_code, message) -> void:
	print("error code: " + str(error_code))
	print("message: " + str(message))
	%LoadingContainer.hide()
	%LoginContainer.show()
	
	
func _on_signup_failed(error_code, message) -> void:
	print("error code: " + str(error_code))
	print("message: " + str(message))	
	%LoadingContainer.hide()
	%LoginContainer.show()
