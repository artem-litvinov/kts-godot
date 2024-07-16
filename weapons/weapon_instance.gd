extends Node2D
class_name WeaponInstance

var _weapon_stats: SurvivalWeaponStats
var _in_cooldown: bool
var _remaining_cooldown: float


func set_stats(stats: SurvivalWeaponStats) -> void:
	_weapon_stats = stats


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
	_remaining_cooldown = _weapon_stats.cooldown


func attack() -> bool:
	return false
