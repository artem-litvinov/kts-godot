extends Area2D

class_name HitboxComponent

signal got_hit(attack)


func hit(attack: Attack):
	got_hit.emit(attack)
