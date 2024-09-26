extends Node2D

@export var use_mocks: bool
@export var exit_popup: PackedScene


func _ready() -> void:
	if use_mocks:
		GameState.initialize_user(Mocks.mock_user)
		GameState.initialize_heroes(Mocks.mock_heroes)
		GameState.initialize_world_state(Mocks.mock_world_state)
		GameState.survival_started(Mocks.mock_heroes.pick_random().id)

	var hero = GameState.get_hero_by_id(GameState.get_selected_hero_id())
	%SurvivalHero.initialize(hero)

	EventBus.HERO_DEATH.connect(_on_hero_death)


func _process(delta: float) -> void:
	%MistParallaxBackground.scroll_base_offset -= Vector2(100, 0) * delta


func _on_hero_death() -> void:
	var _exit_popup: UISurvivalExitScreen = exit_popup.instantiate()
	_exit_popup.initialize(false)
	%CanvasLayer.add_child(_exit_popup)
	_exit_popup.exit.connect(_on_exit)


func _on_exit() -> void:
	var hp = %SurvivalStatsTracker.hero_hp
	GameState.update_hero_by_id(GameState.get_selected_hero_id(), %SurvivalStatsTracker.hero_hp)
	GameState.survival_ended()
	SceneManager.goto_village()
