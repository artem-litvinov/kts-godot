extends Node

var _user: User
var _world_state: WorldState
var _hero_by_id: Dictionary
var _game_mode: Enums.GameMode = Enums.GameMode.VILLAGE
var _selected_hero_id: String


func get_user() -> User:
	return _user


func get_world_state() -> WorldState:
	return _world_state


func get_heroes() -> Array[Hero]:
	var heroes: Array[Hero] = []
	for id in _hero_by_id:
		heroes.append(_hero_by_id[id] as Hero)
	return heroes


func initialize_user(user: User) -> void:
	_user = user
	print("Logged in as: " + _user.to_string())


func initialize_world_state(world_state: WorldState) -> void:
	_world_state = world_state
	print("Inirial world state: " + _world_state.to_string())


func initialize_heroes(heroes: Array[Hero]) -> void:
	for hero in heroes:
		_hero_by_id[hero.id] = hero
	print("Initial heroes: ")
	for id in _hero_by_id:
		print(_hero_by_id[id].to_string())


func update_world_state(supplies_delta: int) -> void:
	_world_state.supplies += supplies_delta


func add_hero(hero: Hero) -> void:
	_hero_by_id[hero.id] = hero


func get_hero_by_id(id: String) -> Hero:
	return _hero_by_id.get(id)


func update_hero_by_id(id: String, current_hp: int) -> void:
	var hero = _hero_by_id[id]
	hero.current_hp = current_hp


func village_event_started() -> void:
	_selected_hero_id = ""
	_game_mode = Enums.GameMode.VILLAGE_EVENT


func village_event_ended() -> void:
	_selected_hero_id = ""
	_game_mode = Enums.GameMode.VILLAGE


func scavenge_started(hero_id: String) -> void:
	_selected_hero_id = hero_id
	_game_mode = Enums.GameMode.SCAVENGE


func scavenge_ended() -> void:
	_selected_hero_id = ""
	_game_mode = Enums.GameMode.VILLAGE


func survival_started(hero_id: String) -> void:
	_selected_hero_id = hero_id
	_game_mode = Enums.GameMode.SURVIVAL


func survival_ended() -> void:
	_selected_hero_id = ""
	_game_mode = Enums.GameMode.VILLAGE


func get_selected_hero_id() -> String:
	return _selected_hero_id
