extends Node2D
class_name LevelingComponent

signal leveled_up(current_level: int)

@export var xp_to_first_level: int = 100
@export var xp_delta_per_level_percentage: float = 100.0

var _current_xp: int = 0
var _current_level: int = 1

@onready var _next_level_xp: int = xp_to_first_level


func add_xp(amount: int):
	_current_xp += amount
	while _current_xp >= _next_level_xp:
		_level_up()


func _level_up():
	_current_level += 1
	_current_xp -= _next_level_xp
	_next_level_xp = int(_next_level_xp * (1 + xp_delta_per_level_percentage / 100.0))
	leveled_up.emit(_current_level)
