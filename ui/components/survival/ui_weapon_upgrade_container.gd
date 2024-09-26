extends PanelContainer
class_name UIWeaponUpgradeContainer

signal selected(weapon: SurvivalWeapon)

@export var _weapon_stat_change_scene: PackedScene

var _weapon: SurvivalWeapon

func initialize(weapon: SurvivalWeapon):
	_weapon = weapon

	%Name.text = weapon.name
	%Description.text = weapon.description

	for child in %StatChangesContainer.get_children():
		child.queue_free()

	var current_level_stats: SurvivalWeaponStats = SurvivalWeaponStats.new()
	if weapon.level > 0:
		var level = weapon.level
		current_level_stats = weapon.stats_per_level[weapon.level - 1]
	var next_level_stats: SurvivalWeaponStats = weapon.stats_per_level[weapon.level]

	if current_level_stats.damage != next_level_stats.damage:
		var stat_change: UIWeaponStatChangeContainer = _weapon_stat_change_scene.instantiate()
		stat_change.initialize("Damage", str(current_level_stats.damage), str(next_level_stats.damage))
		%StatChangesContainer.add_child(stat_change)

	if current_level_stats.knockback != next_level_stats.knockback:
		var stat_change: UIWeaponStatChangeContainer = _weapon_stat_change_scene.instantiate()
		stat_change.initialize("Knockback", str(current_level_stats.knockback), str(next_level_stats.knockback))
		%StatChangesContainer.add_child(stat_change)

	if current_level_stats.stun_time != next_level_stats.stun_time:
		var stat_change: UIWeaponStatChangeContainer = _weapon_stat_change_scene.instantiate()
		stat_change.initialize("Stun Time", str(current_level_stats.stun_time), str(next_level_stats.stun_time))
		%StatChangesContainer.add_child(stat_change)

	if current_level_stats.cooldown != next_level_stats.cooldown:
		var stat_change: UIWeaponStatChangeContainer = _weapon_stat_change_scene.instantiate()
		stat_change.initialize("Cooldown", str(current_level_stats.cooldown), str(next_level_stats.cooldown))
		%StatChangesContainer.add_child(stat_change)

	if current_level_stats.reach != next_level_stats.reach:
		var stat_change: UIWeaponStatChangeContainer = _weapon_stat_change_scene.instantiate()
		stat_change.initialize("Reach", str(current_level_stats.reach), str(next_level_stats.reach))
		%StatChangesContainer.add_child(stat_change)

	if current_level_stats.piercing != next_level_stats.piercing:
		var stat_change: UIWeaponStatChangeContainer = _weapon_stat_change_scene.instantiate()
		stat_change.initialize("Piercing", str(current_level_stats.piercing), str(next_level_stats.piercing))
		%StatChangesContainer.add_child(stat_change)

	if current_level_stats.projectile_count != next_level_stats.projectile_count:
		var stat_change: UIWeaponStatChangeContainer = _weapon_stat_change_scene.instantiate()
		stat_change.initialize("Projectile Count", str(current_level_stats.projectile_count), str(next_level_stats.projectile_count))
		%StatChangesContainer.add_child(stat_change)

	if current_level_stats.projectile_speed != next_level_stats.projectile_speed:
		var stat_change: UIWeaponStatChangeContainer = _weapon_stat_change_scene.instantiate()
		stat_change.initialize("Projectile Speed", str(current_level_stats.projectile_speed), str(next_level_stats.projectile_speed))
		%StatChangesContainer.add_child(stat_change)


func _on_button_pressed() -> void:
	selected.emit(_weapon)
