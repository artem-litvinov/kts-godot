extends Control

signal hero_selected(hero)

@export var use_mocks: bool = false

var _hero_by_idx: Dictionary
var _selected_hero: Hero


func _ready() -> void:
	if use_mocks:
		initialize(Mocks.mock_heroes)


func initialize(heroes: Array[Hero]) -> void:
	for hero in heroes:
		var tier_texture = load(SpriteManager.get_tier_sprite_path(hero.tier))
		var idx = %HeroOptionButton.item_count
		%HeroOptionButton.add_icon_item(tier_texture, hero.name, idx)
		_hero_by_idx[idx] = hero


func disable_button() -> void:
	%Button.disabled = true


func _on_hero_option_button_item_selected(index: int) -> void:
	if index not in _hero_by_idx:
		_selected_hero = null
		return

	var hero = _hero_by_idx[index]
	_selected_hero = hero
	%HeroDisplayContainer.initialize(hero, true)
	%HeroDisplayContainer.show()


func _on_button_pressed() -> void:
	if _selected_hero == null:
		return
	
	hero_selected.emit(_selected_hero)
