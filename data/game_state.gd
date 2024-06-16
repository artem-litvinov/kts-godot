extends Node

var user: User
var world: World


func initialise_user(_id: String, _name: String):
	user = User.new(_id, _name)
	print("Logged in as: " + user.to_string())


func initialise_world(food: int, morale: int, supplies: int):
	world = World.new(food, morale, supplies)
	print("Inirial world state: " + world.to_string())
