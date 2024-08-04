extends SurvivalWeaponInstance
class_name SurvivalRangedWeaponInstance

@onready var _weapon_radius: Area2D = %WeaponRadius
@onready var _pivot_point: Marker2D = %PivotPoint
@onready var _attack_point: Marker2D = %AttackPoint


func attack() -> bool:
	var enemies_in_range = _weapon_radius.get_overlapping_bodies()
	if enemies_in_range.size() < 1:
		return false

	var _weapon_stats = _weapon.stats_per_level[_weapon.level - 1]
	# starting with -1 to simplify the code and get 0 index on the first iteration
	var index: int = -1
	for _i in range(0, _weapon_stats.projectile_count + _hero_stats.projectile_count_modifier):
		index = _get_next_enemy_index(enemies_in_range, index)
		var target_enemy: PhysicsBody2D = enemies_in_range[index]
		_pivot_point.look_at(target_enemy.global_position)

		var new_projectile: SurvivalProjectile = _weapon.projectile_scene.instantiate()
		new_projectile.global_position = _attack_point.global_position
		new_projectile.global_rotation = _attack_point.global_rotation
		new_projectile.initialize(_hero_stats, _weapon_stats)
		_attack_point.add_child(new_projectile)

	return true


func _get_next_enemy_index(enemies: Array[Node2D], last_index: int) -> int:
	var next_index: int = last_index + 1
	if next_index >= enemies.size():
		next_index = 0
	return next_index


func update_reach(stats: SurvivalHeroStatsComponent) -> void:
	var weapon_reach = _weapon.stats_per_level[_weapon.level - 1].reach
	var reach_increase = (weapon_reach / 100) * stats.reach_modifier
	var final_reach = weapon_reach + reach_increase
	%CollisionShape2D.shape.radius = final_reach
