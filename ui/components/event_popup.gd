extends Control

signal option_selected(option)

const EVENT_OPTION_SCENE = preload("res://ui/components/event_option.tscn")

@export var use_mocks: bool

var _hero: Hero
var _event: Events.AIEvent
var _option_buttons: Array[Node]
var _selected_option_idx: int = -1


func _ready():
	if use_mocks:
		initialize(Mocks.mock_heroes.pick_random(), Mocks.mock_event)


func initialize(hero: Hero, event: Events.AIEvent):
		_hero = hero
		_event = event

		%Button.disabled = true
		%EventDescription.text = event.description
		%Hero.initialize(hero.name, hero.attack, hero.currentHP)
		%Enemy.initialize(event.enemy.name, event.enemy.attack, event.enemy.hp)
		var option_idx: int = 0
		for option in event.options:
			var option_button = EVENT_OPTION_SCENE.instantiate()
			option_button.text = option.description
			var callback: Callable = func(toggled_on: bool):
				_on_option_toggled(option_idx, toggled_on)
			option_button.connect("toggled", callback)
			%OptionsContainer.add_child(option_button)
			_option_buttons.append(option_button)
			option_idx += 1


func _on_option_toggled(idx: int, toggled_on: bool):
	if !toggled_on:
		_selected_option_idx = -1
		%Button.disabled = true
		return

	var option_idx: int = 0
	for button in _option_buttons:
		var text = button.text
		if idx == option_idx:
			button.button_pressed = true
		else:
			button.button_pressed = false
		option_idx += 1
	_selected_option_idx = idx
	%Button.disabled = false


func _on_button_pressed() -> void:
	if _selected_option_idx == -1:
		return

	option_selected.emit(_event.options[_selected_option_idx])
