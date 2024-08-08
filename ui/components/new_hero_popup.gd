extends Control

signal button_pressed

@export var use_mocks: bool = false


func _ready() -> void:
	if use_mocks:
		initialize(Mocks.mock_heroes.pick_random())


func initialize(hero: Hero) -> void:
	%HeroDisplayContainer.initialize(hero, false)


func _on_button_pressed() -> void:
	button_pressed.emit()
