extends Node2D

const HERO_SCENE: PackedScene = preload("res://heroes/hero.tscn")


func _ready():
	if OS.is_debug_build():
		GameState.initialise_user(Mocks.mock_user)
		GameState.initialise_world_state(Mocks.mock_world_state)
		GameState.initialise_heroes(Mocks.mock_heroes)

	if !GameState.world_state.passed_tutorial:
		_start_tutorial()


func _start_tutorial() -> void:
	%TextPopup.set_text_content(
		Strings.TUTORIAL_HEADER,
		Strings.TUTORIAL_BODY,
		Strings.TUTORIAL_BUTTON,
	)
	%TextPopup.connect("button_pressed", _on_tutorial_button_pressed)
	%TextPopup.show()


func _on_tutorial_button_pressed() -> void:
	%TextPopup.disconnect("button_pressed", _on_tutorial_button_pressed)
	%TextPopup.disable_button()
	BackendAPI.generate_hero(GameState.user.id, _on_tutorial_hero_generated)


func _on_tutorial_hero_generated(hero: Hero, error: Error) -> void:
	if error != OK:
		print("Failed to generate tutorial hero: ", error)
		%TextPopup.hide()
		return

	GameState.add_hero(hero)
	var new_hero = HERO_SCENE.instantiate()
	new_hero.initialise(hero)
	add_child(new_hero)
	%TextPopup.hide()
	%NewHeroPopup.set_hero_data(hero)
	%NewHeroPopup.show()


func _on_new_hero_popup_button_pressed() -> void:
	%NewHeroPopup.hide()


func _on_building_missions_board_clicked() -> void:
	%TextPopup.set_text_content("Board Header", Strings.TUTORIAL_BODY, "board button")
	%TextPopup.connect("button_pressed", _on_board_button_pressed)
	%TextPopup.show()


func _on_board_button_pressed() -> void:
	%TextPopup.disconnect("button_pressed", _on_board_button_pressed)
	%TextPopup.hide()
