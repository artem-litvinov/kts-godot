extends Node2D

const HERO_SCENE: PackedScene = preload("res://heroes/hero.tscn")
const TEXT_POPUP_SCENE: PackedScene = preload("res://ui/components/text_popup.tscn")
const NEW_HERO_POPUP_SCENE: PackedScene = preload("res://ui/components/new_hero_popup.tscn")

var text_popup: Control
var new_hero_popup: Control


func _ready():
	if OS.is_debug_build():
		GameState.initialize_user(Mocks.mock_user)
		GameState.initialize_world_state(Mocks.mock_world_state)
		GameState.initialize_heroes(Mocks.mock_heroes)

	if !GameState.world_state.passed_tutorial:
		_start_tutorial()


func _start_tutorial() -> void:
	_show_text_popup(
		Strings.TUTORIAL_HEADER,
		Strings.TUTORIAL_BODY,
		Strings.TUTORIAL_BUTTON,
		_on_tutorial_button_pressed,
	)


# Callbacks
# --------------------------------------------------
func _on_tutorial_button_pressed() -> void:
	text_popup.disconnect("button_pressed", _on_tutorial_button_pressed)
	text_popup.disable_button()
	BackendAPI.generate_hero(GameState.user.id, _on_tutorial_hero_generated)


func _on_tutorial_hero_generated(hero: Hero, error: Error) -> void:
	if error != OK:
		print("Failed to generate tutorial hero: ", error)
		_remove_text_popup()
		return

	_remove_text_popup()
	GameState.add_hero(hero)
	var new_hero = HERO_SCENE.instantiate()
	new_hero.initialize(hero)
	add_child(new_hero)
	_show_new_hero_popup(hero, _on_new_hero_popup_button_pressed)


func _on_new_hero_popup_button_pressed() -> void:
	_remove_new_hero_popup()


func _on_building_missions_board_clicked() -> void:
	_show_text_popup(
		"Board header",
		Strings.TUTORIAL_BODY,
		"Board button",
		_on_board_button_pressed,
	)


func _on_board_button_pressed() -> void:
	_remove_text_popup()


# Helpers
# --------------------------------------------------
func _show_text_popup(header: String, body: String, button: String, callback: Callable) -> void:
	text_popup = TEXT_POPUP_SCENE.instantiate()
	text_popup.initialize(header, body, button)
	%CanvasLayer.add_child(text_popup)
	text_popup.connect("button_pressed", callback)


func _remove_text_popup() -> void:
	%CanvasLayer.remove_child(text_popup)
	text_popup = null


func _show_new_hero_popup(hero: Hero, callback: Callable) -> void:
	new_hero_popup = NEW_HERO_POPUP_SCENE.instantiate()
	new_hero_popup.initialize(hero)
	%CanvasLayer.add_child(new_hero_popup)
	new_hero_popup.connect("button_pressed", callback)


func _remove_new_hero_popup() -> void:
	%CanvasLayer.remove_child(new_hero_popup)
	new_hero_popup = null
