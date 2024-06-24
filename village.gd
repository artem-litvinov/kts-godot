extends Node2D

const HERO_SCENE: PackedScene = preload("res://heroes/hero.tscn")

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
