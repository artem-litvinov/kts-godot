extends Node2D
class_name SurvivalHeroUpgradesComponent

@export var hero_stats_component: SurvivalHeroStatsComponent
@export var all_upgrades: Array[SurvivalHeroUpgrade]

var _upgrades: Array[SurvivalHeroUpgrade] = []


func get_upgradable_upgrades() -> Array[SurvivalHeroUpgrade]:
	var upgradable_upgrades: Array[SurvivalHeroUpgrade] = []
	for upgrade in all_upgrades:
		if upgrade.level < upgrade.max_level:
			upgradable_upgrades.append(upgrade)
	return upgradable_upgrades


func add_upgrade(upgrade: SurvivalHeroUpgrade) -> void:
	upgrade.level += 1
	_upgrades.append(upgrade)
	hero_stats_component.apply_permanent_modifier(upgrade.stats_modifier)
