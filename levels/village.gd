extends Node2D

const HERO_SCENE: PackedScene = preload("res://heroes/village_hero.tscn")
const TEXT_POPUP_SCENE: PackedScene = preload("res://ui/components/text_popup.tscn")
const NEW_HERO_POPUP_SCENE: PackedScene = preload("res://ui/components/new_hero_popup.tscn")
const BOARD_POPUP_SCENE: PackedScene = preload("res://ui/components/board_popup.tscn")
const HERO_SELECT_POPUP_SCENE: PackedScene = preload("res://ui/components/hero_select_popup.tscn")
const EVENT_POPUP_SCENE: PackedScene = preload("res://ui/components/event_popup.tscn")
const EVENT_RESULTS_POPUP_SCENE: PackedScene = preload("res://ui/components/event_results_popup.tscn")

@export var use_mocks: bool = false 

var _text_popup: Control
var _new_hero_popup: Control
var _board_popup: Control
var _hero_select_popup: Control
var _event_popup: Control
var _event_results_popup: Control

var _spawn_points: Array[Node]
var _spawn_index: int = 0


func _ready():
	_spawn_points = get_tree().get_nodes_in_group("spawn_points")
	_spawn_points.shuffle()

	if use_mocks:
		GameState.initialize_user(Mocks.mock_user)
		GameState.initialize_world_state(Mocks.mock_world_state)
		GameState.initialize_heroes(Mocks.mock_heroes)

	update_hud()

	for hero in GameState.get_heroes():
		_spawn_hero(hero, _get_spawn_point())

	# SoundManager setup
	if SoundManager.instance:
		SoundManager.instance.add_sound_pool("VillageAmbienceSoundPool", %VillageAmbienceSoundPool)	
		SoundManager.instance.play_pool("VillageAmbienceSoundPool")
		SoundManager.instance.add_sound_pool("VillageEnvironmentAmbienceSoundPool", %VillageEnvironmentAmbienceSoundPool)	
		SoundManager.instance.play_pool("VillageEnvironmentAmbienceSoundPool") 


func _start_tutorial() -> void:
	_show_text_popup(
		Strings.TUTORIAL_HEADER,
		Strings.TUTORIAL_BODY,
		Strings.TUTORIAL_BUTTON,
		_on_tutorial_button_pressed,
	)


# Callbacks
# --------------------------------------------------
func _on_building_bar_clicked() -> void:
	if !GameState.get_world_state().passed_tutorial:
		_start_tutorial()


func _on_tutorial_button_pressed() -> void:
	_text_popup.disconnect("button_pressed", _on_tutorial_button_pressed)
	_text_popup.disable_button()
	BackendAPI.generate_hero(GameState.get_user().id, _on_tutorial_hero_generated)


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
	%EventBackground.show()
	_show_hero_select_popup(Strings.SCAVENGE_MISSION_DESC, _on_scavenge_hero_selected)


func _on_survival_mode_selected() -> void:
	_remove_board_popup()
	_show_hero_select_popup(Strings.SURVIVAL_MISSION_DESC, _on_survival_hero_selected)


func _on_board_popup_close() -> void:
	_remove_board_popup()


func _on_scavenge_hero_selected(hero_id: String) -> void:
	GameState.scavenge_started(hero_id)
	BackendAPI.generate_event(
		GameState.get_user().id,
		GameState.get_world_state(),
		GameState.get_hero_by_id(hero_id),
		_on_event_generated,
	)
	_hero_select_popup.disable_button()


func _on_survival_hero_selected(hero_id: String) -> void:
	GameState.survival_started(hero_id)
	SceneManager.goto_survival()


func _on_event_generated(event: Events.AIEvent, error: Error) -> void:
	if error != OK:
		print("Failed to generate event: ", error)
		_remove_hero_select_popup()
		return

	_remove_hero_select_popup()
	var selected_hero = GameState.get_hero_by_id(GameState.get_selected_hero_id())
	_show_event_popup(selected_hero, event)


func _on_option_selected(option: Events.Option) -> void:
	_remove_event_popup()
	var results = option.results
	GameState.update_world_state(results.food_delta, results.morale_delta, results.supplies_delta)
	GameState.update_hero_by_id(GameState.get_selected_hero_id(), results.hp_delta)
	_show_event_results_popup(
		GameState.get_world_state(),
		GameState.get_hero_by_id(GameState.get_selected_hero_id()),
		results,
	)


func _on_event_results_confirmed() -> void:
	_remove_event_results_popup()
	%EventBackground.hide()
	update_hud()


# Helpers
# --------------------------------------------------
func update_hud() -> void:
	var world_state = GameState.get_world_state()
	%VillageHUD.update_resources(world_state.food, world_state.morale, world_state.supplies)


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


# UI Helpers
# --------------------------------------------------
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


func _show_hero_select_popup(description: String, callback: Callable) -> void:
	_hero_select_popup = HERO_SELECT_POPUP_SCENE.instantiate()
	_hero_select_popup.initialize(description, GameState.get_heroes())
	%CanvasLayer.add_child(_hero_select_popup)
	_hero_select_popup.connect("hero_selected", callback)


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


func _show_event_results_popup(world: WorldState, hero: Hero, results: Events.OptionResults) -> void:
	_event_results_popup = EVENT_RESULTS_POPUP_SCENE.instantiate()
	_event_results_popup.initialize(world, hero, results)
	%CanvasLayer.add_child(_event_results_popup)
	_event_results_popup.connect("button_pressed", _on_event_results_confirmed)


func _remove_event_results_popup() -> void:
	%CanvasLayer.remove_child(_event_results_popup)
	_event_results_popup = null
