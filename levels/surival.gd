extends Node2D

@export var use_mocks: bool


func _ready() -> void:
	if use_mocks:
		GameState.initialize_heroes(Mocks.mock_heroes)
		GameState.survival_started(Mocks.mock_heroes.pick_random().id)

	var hero = GameState.get_hero_by_id(GameState.get_selected_hero_id())
	%SurvivalHero.initialize(hero)
