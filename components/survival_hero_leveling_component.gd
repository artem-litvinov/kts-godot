extends Node2D
class_name SurvivalHeroLevelingComponent

signal leveled_up(current_level: int, xp_to_next_level)
signal xp_changed(current_xp: int)

@export var xp_to_first_level: int = 100
@export var xp_delta_per_level_percentage: float = 100.0

var _current_xp: int = 0:
	get:
		return _current_xp
	set(value):
		_current_xp = clamp(value, 0, _next_level_xp)
		xp_changed.emit(_current_xp)

var _current_level: int = 1

@onready var _next_level_xp: int = xp_to_first_level


func get_xp_to_next_level() -> int:
	return _next_level_xp


func get_current_xp() -> int:
	return _current_xp


func get_current_level() -> int:
	return _current_level


func add_xp(amount: int):
	_current_xp += amount
	while _current_xp >= _next_level_xp:
		_level_up()


func _level_up():
	_current_level += 1
	_current_xp = 0
	_next_level_xp = int(_next_level_xp * (1 + xp_delta_per_level_percentage / 100.0))
	leveled_up.emit(_current_level, _next_level_xp)
