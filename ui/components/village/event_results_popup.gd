extends Control

signal button_pressed

@export var use_mocks: bool = false


func _ready() -> void:
	if use_mocks:
		var results = Mocks.mock_event.options.pick_random().results
		var hero = Mocks.mock_heroes.pick_random()
		var world = Mocks.mock_world_state
		initialize(world, hero, results)


func initialize(world: WorldState, hero: Hero, results: Events.OptionResults):
	%ResultsDescription.text = results.description

	if hero:
		%HeroName.text = hero.name
		%HeroHealth.initialize(hero.current_hp, results.hp_delta)
	else:
		%HeroChanges.hide()

	%Supplies.initialize(world.supplies, results.supplies_delta)


func _on_button_pressed() -> void:
	button_pressed.emit()
