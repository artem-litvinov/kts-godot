extends Resource
class_name WorldState

var supplies: int
var passed_tutorial: bool


func _to_string():
	return "World: supplies - " + str(supplies)


static func from_json(json: Dictionary) -> WorldState:
	var state = WorldState.new()

	state.supplies = json["supplies"]
	state.passed_tutorial = json["passedTutorial"]

	return state


static func from_params(_supplies: int, _passed_tutorial) -> WorldState:
	var state = WorldState.new()

	state.supplies = _supplies
	state.passed_tutorial = _passed_tutorial

	return state
