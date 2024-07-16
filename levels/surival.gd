extends Node2D

@export var use_mocks: bool
@export var weapon_list: Array[SurvivalWeapon]


func _ready() -> void:
	if use_mocks:
		GameState.initialize_heroes(Mocks.mock_heroes)
		GameState.survival_started(Mocks.mock_heroes.pick_random().id)
		var weapon: SurvivalWeapon = weapon_list.pick_random()
		var weapon_instance: WeaponInstance = weapon.weapon_scene.instantiate()
		weapon_instance.set_stats(weapon.stats)
		if weapon_instance is RangedWeaponInstance:
			weapon_instance.set_projectile(weapon.projectile_scene)
		%SurvivalHero.add_child(weapon_instance)

	var hero = GameState.get_hero_by_id(GameState.get_selected_hero_id())
	%SurvivalHero.initialize(hero)


func _process(delta: float) -> void:
	%MistParallaxBackground.scroll_base_offset -= Vector2(100, 0) * delta
