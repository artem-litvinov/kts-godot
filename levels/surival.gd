extends Node2D


func _ready() -> void:
	var hero = GameState.get_hero_by_id(GameState.get_selected_hero_id())
	print(hero.to_string())
