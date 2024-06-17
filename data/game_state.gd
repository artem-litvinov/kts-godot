extends Node

var user: User
var world_state: WorldState


func initialise_user(_user: User):
	user = _user
	print("Logged in as: " + user.to_string())


func initialise_world(_world_state: WorldState):
	world_state = _world_state
	print("Inirial world state: " + world_state.to_string())
