extends PanelContainer
class_name UIHeroUpgradeContainer

signal selected(upgrade: SurvivalHeroUpgrade)

const HERO_STAT_CHANGE_SCENE: PackedScene = preload("res://ui/components/survival/ui_hero_stat_change_container.tscn")

var _upgrade: SurvivalHeroUpgrade


func initialize(upgrade: SurvivalHeroUpgrade):
	_upgrade = upgrade

	%Name.text = upgrade.name
	%Description.text = upgrade.description

	for child in %StatChangesContainer.get_children():
		child.queue_free()

	if upgrade.stats_modifier.max_hp != 0:
		var stat_change: UIHeroStatChangeContainer = HERO_STAT_CHANGE_SCENE.instantiate()
		stat_change.initialize("Max HP", str(upgrade.stats_modifier.max_hp), "")
		%StatChangesContainer.add_child(stat_change)

	if upgrade.stats_modifier.speed_modifier != 0:
		var stat_change: UIHeroStatChangeContainer = HERO_STAT_CHANGE_SCENE.instantiate()
		stat_change.initialize("Speed", str(upgrade.stats_modifier.speed_modifier), "%")
		%StatChangesContainer.add_child(stat_change)

	if upgrade.stats_modifier.xp_magnet_area_modifier != 0:
		var stat_change: UIHeroStatChangeContainer = HERO_STAT_CHANGE_SCENE.instantiate()
		stat_change.initialize("XP Magnet Area", str(upgrade.stats_modifier.xp_magnet_area_modifier), "%")
		%StatChangesContainer.add_child(stat_change)

	if upgrade.stats_modifier.damage != 0:
		var stat_change: UIHeroStatChangeContainer = HERO_STAT_CHANGE_SCENE.instantiate()
		stat_change.initialize("Damage", str(upgrade.stats_modifier.damage), "")
		%StatChangesContainer.add_child(stat_change)

	if upgrade.stats_modifier.damage_modifier != 0:
		var stat_change: UIHeroStatChangeContainer = HERO_STAT_CHANGE_SCENE.instantiate()
		stat_change.initialize("Damage modifier", str(upgrade.stats_modifier.damage_modifier), "%")
		%StatChangesContainer.add_child(stat_change)

	if upgrade.stats_modifier.cooldown_modifier != 0:
		var stat_change: UIHeroStatChangeContainer = HERO_STAT_CHANGE_SCENE.instantiate()
		stat_change.initialize("Cooldown", str(upgrade.stats_modifier.cooldown_modifier), "%")
		%StatChangesContainer.add_child(stat_change)

	if upgrade.stats_modifier.reach_modifier != 0:
		var stat_change: UIHeroStatChangeContainer = HERO_STAT_CHANGE_SCENE.instantiate()
		stat_change.initialize("Reach", str(upgrade.stats_modifier.reach_modifier), "%")
		%StatChangesContainer.add_child(stat_change)

	if upgrade.stats_modifier.piercing_modifier != 0:
		var stat_change: UIHeroStatChangeContainer = HERO_STAT_CHANGE_SCENE.instantiate()
		stat_change.initialize("Piercing", str(upgrade.stats_modifier.piercing_modifier), "")
		%StatChangesContainer.add_child(stat_change)

	if upgrade.stats_modifier.projectile_count_modifier != 0:
		var stat_change: UIHeroStatChangeContainer = HERO_STAT_CHANGE_SCENE.instantiate()
		stat_change.initialize("Projectile Count", str(upgrade.stats_modifier.projectile_count_modifier), "")
		%StatChangesContainer.add_child(stat_change)

	if upgrade.stats_modifier.projectile_speed_modifier != 0:
		var stat_change: UIHeroStatChangeContainer = HERO_STAT_CHANGE_SCENE.instantiate()
		stat_change.initialize("Projectile Speed", str(upgrade.stats_modifier.projectile_speed_modifier), "%")
		%StatChangesContainer.add_child(stat_change)


func _on_button_pressed() -> void:
	selected.emit(_upgrade)
