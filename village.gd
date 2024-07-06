extends Node2D

const HERO_SCENE: PackedScene = preload("res://heroes/hero.tscn")
const TEXT_POPUP_SCENE: PackedScene = preload("res://ui/components/text_popup.tscn")
const NEW_HERO_POPUP_SCENE: PackedScene = preload("res://ui/components/new_hero_popup.tscn")
const BOARD_POPUP_SCENE: PackedScene = preload("res://ui/components/board_popup.tscn")
const HERO_SELECT_POPUP_SCENE: PackedScene = preload("res://ui/components/hero_select_popup.tscn")
const EVENT_POPUP_SCENE: PackedScene = preload("res://ui/components/event_popup.tscn")

var _spawn_points: Array[Node]
var _spawn_index: int = 0
var _text_popup: Control
var _new_hero_popup: Control
var _board_popup: Control
var _hero_select_popup: Control
var _event_popup: Control

var _selected_event_hero: Hero


func _ready():
	_spawn_points = get_tree().get_nodes_in_group("spawn_points")
	_spawn_points.shuffle()

	if OS.is_debug_build():
		GameState.initialize_user(Mocks.mock_user)
		GameState.initialize_world_state(Mocks.mock_world_state)
		GameState.initialize_heroes(Mocks.mock_heroes)

	for hero in GameState.heroes:
		_spawn_hero(hero, _get_spawn_point())

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
	_text_popup.disconnect("button_pressed", _on_tutorial_button_pressed)
	_text_popup.disable_button()
	BackendAPI.generate_hero(GameState.user.id, _on_tutorial_hero_generated)


func _on_tutorial_hero_generated(hero: Hero, error: Error) -> void:
	if error != OK:
		print("Failed to generate tutorial hero: ", error)
		_remove_text_popup()
		return

	GameState.add_hero(hero)
	_remove_text_popup()
	_spawn_hero(hero, _get_spawn_point())
	_show_new_hero_popup(hero, _on_new_hero_popup_button_pressed)


func _on_new_hero_popup_button_pressed() -> void:
	_remove_new_hero_popup()


func _on_building_missions_board_clicked() -> void:
	_show_board_popup()


func _on_scavenge_mode_selected() -> void:
	_remove_board_popup()
	_show_hero_select_popup()


func _on_survival_mode_selected() -> void:
	_remove_board_popup()


func _on_board_popup_close() -> void:
	_remove_board_popup()


func _on_hero_selected(hero: Hero) -> void:
	_selected_event_hero = hero
	BackendAPI.generate_event(GameState.user.id, GameState.world_state, hero, _on_event_generated)
	_hero_select_popup.disable_button()


func _on_event_generated(event: Events.AIEvent, error: Error) -> void:
	if error != OK:
		print("Failed to generate event: ", error)
		_remove_hero_select_popup()
		return

	_remove_hero_select_popup()
	_show_event_popup(_selected_event_hero, event)


func _on_option_selected(_option: Events.Option) -> void:
	_remove_event_popup()


# Helpers
# --------------------------------------------------
func _spawn_hero(hero: Hero, hero_position: Vector2) -> void:
	var new_hero = HERO_SCENE.instantiate()
	new_hero.global_position = hero_position
	new_hero.initialize(hero)
	add_child(new_hero)


func _get_spawn_point() -> Vector2:
	var spawn_point = _spawn_points[_spawn_index]
	if _spawn_index + 1 >= len(_spawn_points):
		_spawn_index = 0
	else:
		_spawn_index += 1
	return spawn_point.global_position


func _show_text_popup(header: String, body: String, button: String, callback: Callable) -> void:
	_text_popup = TEXT_POPUP_SCENE.instantiate()
	_text_popup.initialize(header, body, button)
	%CanvasLayer.add_child(_text_popup)
	_text_popup.connect("button_pressed", callback)


func _remove_text_popup() -> void:
	%CanvasLayer.remove_child(_text_popup)
	_text_popup = null


func _show_new_hero_popup(hero: Hero, callback: Callable) -> void:
	_new_hero_popup = NEW_HERO_POPUP_SCENE.instantiate()
	_new_hero_popup.initialize(hero)
	%CanvasLayer.add_child(_new_hero_popup)
	_new_hero_popup.connect("button_pressed", callback)


func _remove_new_hero_popup() -> void:
	%CanvasLayer.remove_child(_new_hero_popup)
	_new_hero_popup = null


func _show_board_popup() -> void:
	_board_popup = BOARD_POPUP_SCENE.instantiate()
	%CanvasLayer.add_child(_board_popup)
	_board_popup.connect("scavenge_mode_selected", _on_scavenge_mode_selected)
	_board_popup.connect("survival_mode_selected", _on_survival_mode_selected)
	_board_popup.connect("close", _on_board_popup_close)


func _remove_board_popup() -> void:
	%CanvasLayer.remove_child(_board_popup)
	_board_popup = null


func _show_hero_select_popup() -> void:
	_hero_select_popup = HERO_SELECT_POPUP_SCENE.instantiate()
	var heroes = GameState.heroes
	print(len(heroes))
	_hero_select_popup.initialize(GameState.heroes)
	%CanvasLayer.add_child(_hero_select_popup)
	_hero_select_popup.connect("hero_selected", _on_hero_selected)


func _remove_hero_select_popup() -> void:
	%CanvasLayer.remove_child(_hero_select_popup)
	_hero_select_popup = null


func _show_event_popup(hero: Hero, event: Events.AIEvent) -> void:
	_event_popup = EVENT_POPUP_SCENE.instantiate()
	_event_popup.initialize(hero, event)
	%CanvasLayer.add_child(_event_popup)
	_event_popup.connect("option_selected", _on_option_selected)


func _remove_event_popup() -> void:
	%CanvasLayer.remove_child(_event_popup)
	_event_popup = null
