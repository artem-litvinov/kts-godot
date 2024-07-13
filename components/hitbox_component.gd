extends Area2D

signal  got_hit(attack)


func hit(attack: Attack):
	got_hit.emit(attack)
