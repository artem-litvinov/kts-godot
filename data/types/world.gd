extends Resource

class_name WorldState

var food: int
var morale: int
var supplies: int


func _to_string():
	return "{ food: " + str(food) + ", morale: " + str(morale) + ", supplies: " + str(supplies) + "}"


static func from_json(json: Dictionary) -> WorldState:
	var state = WorldState.new()

	for param in json.keys():
		if param in state:
			state.set(param, json[param])
		else:
			return null

	return state


static func from_params(_food: int, _morale: int, _supplies: int) -> WorldState:
	var state = WorldState.new()
	state.food = _food
	state.morale = _morale
	state.supplies = _supplies
	return state
