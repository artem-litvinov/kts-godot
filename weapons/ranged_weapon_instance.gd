extends WeaponInstance
class_name RangedWeaponInstance

var _projectile: PackedScene

@onready var _weapon_radius: Area2D = %WeaponRadius
@onready var _pivot_point: Marker2D = %PivotPoint
@onready var _attack_point: Marker2D = %AttackPoint


func set_projectile(projectile: PackedScene) -> void:
	_projectile = projectile


func attack() -> bool:
	var enemies_in_range = _weapon_radius.get_overlapping_bodies()
	if enemies_in_range.size() <= 0:
		return false

	# starting with -1 to simplify the code and get 0 index on the first iteration
	var index: int = -1
	for _i in range(0, _weapon_stats.projectile_count):
		index = get_next_enemy_index(enemies_in_range, index)
		var target_enemy: PhysicsBody2D = enemies_in_range[index]
		print(target_enemy.global_position)
		_pivot_point.look_at(target_enemy.global_position)

		var new_projectile: Projectile = _projectile.instantiate()
		new_projectile.global_position = _attack_point.global_position
		new_projectile.global_rotation = _attack_point.global_rotation
		new_projectile.weapon_stats = _weapon_stats
		_attack_point.add_child(new_projectile)

	return true


func get_next_enemy_index(enemies: Array[Node2D], last_index: int) -> int:
	var next_index: int = last_index + 1
	if next_index >= enemies.size():
		next_index = 0
	return next_index
