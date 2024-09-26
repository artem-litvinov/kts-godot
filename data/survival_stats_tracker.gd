extends Node
class_name SurvivalStatsTracker

var hero_hp: float


func _ready() -> void:
	EventBus.HERO_HP_CHANGE.connect(_on_hero_hp_change)


func _on_hero_hp_change(hp):
	if hp < 0:
		hero_hp = 0
		return
	hero_hp = hp
