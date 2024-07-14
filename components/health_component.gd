extends Node2D

class_name HealthComponent

signal health_depleted

var _health: float 


func initialize(max_health: float) -> void:
	_health = max_health


func get_health() -> float:
	return _health


func take_damage(dmg_amount: float) -> void:
	_health -= dmg_amount

	if _health <= 0:
		health_depleted.emit()
