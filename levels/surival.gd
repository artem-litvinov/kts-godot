extends Node2D

@export var use_mocks: bool
@export var exit_confirmation_popup: PackedScene
@export var exit_popup: PackedScene

var _confirmation_popup: UISurvivalEarlyExitConfirmationPopup


func _ready() -> void:
	if use_mocks:
		GameState.initialize_user(Mocks.mock_user)
		GameState.initialize_heroes(Mocks.mock_heroes)
		GameState.initialize_world_state(Mocks.mock_world_state)
		GameState.survival_started(Mocks.mock_heroes.pick_random().id)

	var hero = GameState.get_hero_by_id(GameState.get_selected_hero_id())
	%SurvivalHero.initialize(hero)

	SurvivalEventBus.HERO_DEATH.connect(_on_hero_death)
	SurvivalEventBus.EARLY_EXIT_PORTAL_ENTERED.connect(_on_early_exit_portal_entered)
	SurvivalEventBus.GAME_TIMER_REACHED_ZERO.connect(_on_game_timer_reached_zero)


func _process(delta: float) -> void:
	%MistParallaxBackground.scroll_base_offset -= Vector2(100, 0) * delta


func _on_game_timer_reached_zero() -> void:
	get_tree().paused = true
	_show_exit_window(true)


func _on_early_exit_portal_entered() -> void:
	_confirmation_popup = exit_confirmation_popup.instantiate()
	%CanvasLayer.add_child(_confirmation_popup)
	_confirmation_popup.selected.connect(_on_early_exit_option_selected)
	get_tree().paused = true


func _on_hero_death() -> void:
	_show_exit_window(false)


func _on_early_exit_option_selected(is_early_exit_selected: bool) -> void:
	%CanvasLayer.remove_child(_confirmation_popup)
	_confirmation_popup = null
	if is_early_exit_selected:
		_show_exit_window(true)
	else:
		get_tree().paused = false


func _on_exit() -> void:
	GameState.update_hero_by_id(GameState.get_selected_hero_id(), %SurvivalStatsTracker.hero_hp)
	GameState.survival_ended()
	SceneManager.goto_village()
	get_tree().paused = false


# UI Helpers
# --------------------------------------------------
func _show_exit_window(is_alive: bool) -> void:
	var _exit_popup: UISurvivalExitScreen = exit_popup.instantiate()
	_exit_popup.initialize(is_alive)
	%CanvasLayer.add_child(_exit_popup)
	_exit_popup.exit.connect(_on_exit)
