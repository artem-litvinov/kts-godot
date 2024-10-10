extends Area2D
class_name PickupAreaComponent

@export var leveling_component: SurvivalHeroLevelingComponent


func _on_area_entered(area: Area2D) -> void:
	if leveling_component and area is SurvivalXPDropInstance:
		leveling_component.add_xp(area.amount)
		area.queue_free()
