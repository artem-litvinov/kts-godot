extends Node2D
class_name HealthComponent

signal max_health_changed(max_health: float)
signal health_changed(current_health: float)
signal health_depleted

var _max_health: float:
	get:
		return _max_health
	set(value):
		_max_health = value
		max_health_changed.emit(_max_health)

var _health: float:
	get:
		return _health
	set(value):
		_health = clamp(value, 0, _max_health)
		health_changed.emit(_health)


func initialize(max_health: float, current_health: float) -> void:
	_max_health = max_health
	_health = current_health


func get_health() -> float:
	return _health


func get_max_health() -> float:
	return _max_health


func set_max_health(new_max_health: float) -> void:
	var health_percentage: float = _health / _max_health
	_max_health = new_max_health
	_health = health_percentage * _max_health


func take_damage(dmg_amount: float) -> void:
	_health -= dmg_amount

	if _health <= 0:
		health_depleted.emit()
