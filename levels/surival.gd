extends Node2D

@export var use_mocks: bool
@export var weapon_list: Array[SurvivalWeapon]


func _ready() -> void:
	if use_mocks:
		GameState.initialize_heroes(Mocks.mock_heroes)
		GameState.survival_started(Mocks.mock_heroes.pick_random().id)

	var hero = GameState.get_hero_by_id(GameState.get_selected_hero_id())
	%SurvivalHero.initialize(hero)


func _process(delta: float) -> void:
	%MistParallaxBackground.scroll_base_offset -= Vector2(100, 0) * delta
