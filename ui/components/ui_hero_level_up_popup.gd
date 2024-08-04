extends Control
class_name UIHeroLevelUpPopup

signal selected(resource)

var _hero_upgrade_container_scene: PackedScene = preload("res://ui/components/ui_hero_upgrade_container.tscn")
var _weapon_upgrade_container_scene: PackedScene = preload("res://ui/components/ui_weapon_upgrade_container.tscn")


func initialize(resources: Array[Resource]):
	for child in %UpgradesContainer.get_children():
		child.queue_free()

	for resource in resources:
		if resource is SurvivalHeroUpgrade:
			var upgrade_container: UIHeroUpgradeContainer = _hero_upgrade_container_scene.instantiate()
			upgrade_container.initialize(resource)
			upgrade_container.connect("selected", _on_upgrade_selected)
			%UpgradesContainer.add_child(upgrade_container)
		elif resource is SurvivalWeapon:
			var weapon_container: UIWeaponUpgradeContainer = _weapon_upgrade_container_scene.instantiate()
			weapon_container.initialize(resource)
			weapon_container.connect("selected", _on_upgrade_selected)
			%UpgradesContainer.add_child(weapon_container)
		else:
			print("Unknown resource type: " + str(resource))


func _on_upgrade_selected(resource):
	selected.emit(resource)
	queue_free()
