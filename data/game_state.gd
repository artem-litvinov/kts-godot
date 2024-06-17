extends Node

var user: User
var world: World


func initialise_user(_user: User):
	user = _user
	print("Logged in as: " + user.to_string())


func initialise_world(_world: World):
	world = _world
	print("Inirial world state: " + world.to_string())
