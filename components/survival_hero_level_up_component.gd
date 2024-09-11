extends Node2D
class_name SurvivalHeroLevelUpComponent

const UI_LEVEL_UP_POPUP: PackedScene = preload("res://ui/components/survival/ui_hero_level_up_popup.tscn")

@export var hud_layer: CanvasLayer
@export var hero: SurvivalHero
@export var leveling_component: SurvivalHeroLevelingComponent
@export var weapons_component: SurvivalHeroWeaponsComponent
@export var upgrades_component: SurvivalHeroUpgradesComponent

var _popup_instance: UIHeroLevelUpPopup


func _ready() -> void:
	leveling_component.leveled_up.connect(_on_level_up)


func _on_level_up(_level: int) -> void:
	get_tree().paused = true

	var possible_upgrades: Array[Resource] = []
	for upgrade in upgrades_component.get_upgradable_upgrades():
		possible_upgrades.append(upgrade as Resource)
	for upgrade in weapons_component.get_upgradable_weapons():
		possible_upgrades.append(upgrade as Resource)
	possible_upgrades.shuffle()

	var upgrades: Array[Resource] = []
	while upgrades.size() < min(3, possible_upgrades.size()):
		var upgrade: Resource = possible_upgrades.pick_random()

		if upgrade in upgrades:
			continue
		else:
			upgrades.append(upgrade)

	if upgrades.size() < 1:
		get_tree().paused = false
		return

	var popup: UIHeroLevelUpPopup = UI_LEVEL_UP_POPUP.instantiate()
	popup.initialize(upgrades)
	popup.connect("selected", _on_upgrade_selected)
	hud_layer.add_child(popup)
	_popup_instance = popup


func _on_upgrade_selected(resource: Resource) -> void:
	if resource is SurvivalHeroUpgrade:
		upgrades_component.add_upgrade(resource)
	elif resource is SurvivalWeapon:
		weapons_component.add_weapon(resource)
	else:
		print("Unknown resource type: " + str(resource))

	_popup_instance.queue_free()
	get_tree().paused = false
