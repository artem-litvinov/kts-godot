extends Node2D

class_name HealthComponent

signal health_depleted

@export var max_health: float

var health: float 


func _ready() -> void:
	health = max_health


func take_damage(dmg_amount: float) -> void:
	health -= dmg_amount

	if health <= 0:
		health_depleted.emit()
