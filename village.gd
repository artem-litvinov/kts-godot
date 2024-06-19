extends Node2D


func _ready():
	if OS.is_debug_build():
		GameState.initialise_user(Mocks.mock_user)
		GameState.initialise_world_state(Mocks.mock_world_state)
		GameState.initialise_heroes(Mocks.mock_heroes)

	if !GameState.world_state.passed_tutorial:
		%TextPopup.set_header_text(Strings.TUTORIAL_HEADER)
		%TextPopup.set_body_text(Strings.TUTORIAL_BODY)
		%TextPopup.set_button_text(Strings.TUTORIAL_BUTTON)
		%TextPopup.show()


func _on_text_popup_button_pressed() -> void:
	%TextPopup.hide()
