extends Node2D

class_name CharacterCosmetics


func initialize(_sprite_id: String) -> void:
	pass


func play_movement_animations(velocity: Vector2) -> void:
	if velocity.length() > 0:
		var moving_right = velocity.x > 0
		play_running(moving_right)
	else:
		play_idle()


func play_idle() -> void:
	pass


func play_running(_moving_right: bool) -> void:
	pass


func play_hurt() -> void:
	pass


func play_dead() -> void:
	pass
