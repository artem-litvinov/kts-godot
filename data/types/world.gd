-extends Resource

class_name WorldState

var food: int
var morale: int
var supplies: int
var passed_tutorial: bool


func _to_string():
	return "World: food - " + str(food) + ", morale - " + str(morale) + ", supplies - " + str(supplies)


static func from_json(json: Dictionary) -> WorldState:
	var state = WorldState.new()

	state.food = json["food"]
	state.morale = json["morale"]
	state.supplies = json["supplies"]
	state.passed_tutorial = json["passedTutorial"]

	return state


static func from_params(_food: int, _morale: int, _supplies: int, _passed_tutorial) -> WorldState:
	var state = WorldState.new()

	state.food = _food
	state.morale = _morale
	state.supplies = _supplies
	state.passed_tutorial = _passed_tutorial

	return state
