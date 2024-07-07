extends Node

var _user: User
var _world_state: WorldState
var _hero_by_id: Dictionary


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


func update_world_state(food_delta: int, morale_delta: int, supplies_delta: int) -> void:
	_world_state.food += food_delta
	_world_state.morale += morale_delta
	_world_state.supplies += supplies_delta


func add_hero(hero: Hero) -> void:
	_hero_by_id[hero.id] = hero


func get_hero_by_id(id: String) -> Hero:
	return _hero_by_id[id]


func update_hero_by_id(id: String, hp_delta: int) -> void:
	var hero = _hero_by_id[id]
	hero.current_hp += hp_delta
