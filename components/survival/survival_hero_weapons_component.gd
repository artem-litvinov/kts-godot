extends Node2D
class_name SurvivalHeroWeaponsComponent

@export var all_weapons: Array[SurvivalWeapon]

var _hero_stats: SurvivalHeroStatsComponent
var _weapons: Array[SurvivalWeapon] = []
var _weapon_instances: Array[SurvivalWeaponInstance] = []


func initialize(hero_stats: SurvivalHeroStatsComponent) -> void:
	_hero_stats = hero_stats
	_hero_stats.stats_changed.connect(_on_stats_changed)
	add_weapon(all_weapons.pick_random())


func get_upgradable_weapons() -> Array[SurvivalWeapon]:
	var upgradable_weapons: Array[SurvivalWeapon] = []
	for weapon in all_weapons:
		if weapon.level < weapon.max_level:
			upgradable_weapons.append(weapon)
	return upgradable_weapons


func add_weapon(weapon: SurvivalWeapon) -> void:
	if _weapons.find(weapon) != -1:
		if weapon.max_level == weapon.level:
			return
		weapon.level += 1
		return

	weapon.level = 1
	var weapon_instance: SurvivalWeaponInstance = weapon.weapon_scene.instantiate()
	weapon_instance.initialize(_hero_stats, weapon)
	add_child(weapon_instance)
	_weapons.append(weapon)
	_weapon_instances.append(weapon_instance)


func _on_stats_changed(stats: SurvivalHeroStatsComponent) -> void:
	for weapon in _weapon_instances:
		weapon.update_reach(stats)
