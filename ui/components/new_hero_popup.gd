extends Control

signal button_pressed


func initialize(hero: Hero) -> void:
	%HeroDisplayContainer.initialize(hero, false)


func _on_button_pressed() -> void:
	button_pressed.emit()
