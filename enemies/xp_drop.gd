extends Area2D
class_name XPDropInstance

@export var speed: float = 1000

var amount: int

var _is_magnetized: bool = false

@onready var _player: CharacterBody2D = get_tree().get_first_node_in_group("player")


func initialize(drop: XPDrop):
	amount = drop.amount
	$Sprite2D.modulate = drop.color


func magnetize() -> void:
	_is_magnetized = true


func _physics_process(delta: float) -> void:
	if !_is_magnetized:
		return

	var direction = Vector2.ZERO

	if _player:
		direction = global_position.direction_to(_player.global_position)

	var movement_delta = speed * delta
	global_position = global_position + (direction * movement_delta)
