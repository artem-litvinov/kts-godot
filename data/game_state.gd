extends Node

var user: User
var world_state: WorldState
var heroes: Array[Hero]

func initialise_user(_user: User):
	user = _user
	print("Logged in as: " + user.to_string())


func initialise_world_state(_world_state: WorldState):
	world_state = _world_state
	print("Inirial world state: " + world_state.to_string())


func initialise_heroes(_heroes: Array[Hero]):
	heroes = _heroes
	print("Initial heroes: ")
	for hero in heroes:
		print(hero.to_string())
