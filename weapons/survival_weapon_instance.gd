extends Node2D
class_name SurvivalWeaponInstance

var _hero_stats: SurvivalHeroStatsComponent
var _weapon: SurvivalWeapon
var _in_cooldown: bool
var _remaining_cooldown: float


func initialize(hero_stats: SurvivalHeroStatsComponent, weapon: SurvivalWeapon) -> void:
	_hero_stats = hero_stats
	_weapon = weapon


func _physics_process(delta: float) -> void:
	if _in_cooldown:
		_remaining_cooldown -= delta
		if _remaining_cooldown <= 0:
			_in_cooldown = false
			_remaining_cooldown = 0
		return

	var did_attack = attack()
	if !did_attack:
		return

	_in_cooldown = true
	var weapon_cooldown = _weapon.stats_per_level[_weapon.level - 1].cooldown
	_remaining_cooldown = weapon_cooldown - (weapon_cooldown / 100 * _hero_stats.cooldown_modifier)


func attack() -> bool:
	return false


func update_reach(_stats: SurvivalHeroStatsComponent) -> void:
	return
