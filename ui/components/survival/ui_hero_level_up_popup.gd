extends Control
class_name UIHeroLevelUpPopup

signal selected(resource)

const HERO_UPGRADE_CONTAINER_SCENE: PackedScene = preload("res://ui/components/survival/ui_hero_upgrade_container.tscn")
const WEAPON_UPGRADE_CONTAINER_SCENE: PackedScene = preload("res://ui/components/survival/ui_weapon_upgrade_container.tscn")


func initialize(resources: Array[Resource]):
	for child in %UpgradesContainer.get_children():
		child.queue_free()

	for resource in resources:
		if resource is SurvivalHeroUpgrade:
			var upgrade_container: UIHeroUpgradeContainer = HERO_UPGRADE_CONTAINER_SCENE.instantiate()
			upgrade_container.initialize(resource)
			upgrade_container.connect("selected", _on_upgrade_selected)
			%UpgradesContainer.add_child(upgrade_container)
		elif resource is SurvivalWeapon:
			var weapon_container: UIWeaponUpgradeContainer = WEAPON_UPGRADE_CONTAINER_SCENE.instantiate()
			weapon_container.initialize(resource)
			weapon_container.connect("selected", _on_upgrade_selected)
			%UpgradesContainer.add_child(weapon_container)
		else:
			print("Unknown resource type: " + str(resource))


func _on_upgrade_selected(resource):
	selected.emit(resource)
	queue_free()
