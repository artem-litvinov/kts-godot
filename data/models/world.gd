extends Resource

class_name World

var food: int
var morale: int
var supplies: int

func _init(_food: int, _morale: int, _supplies: int) -> void:
	food = _food
	morale = _morale
	supplies = _supplies

func _to_string():
	return "{ food: " + str(food) + ", morale: " + str(morale) + ", supplies: " + str(supplies) + "}"
