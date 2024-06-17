extends Resource

class_name User

var id: String
var name: String

func _init(_id: String, _name: String):
	id = _id
	name = _name

func _to_string():
	return "{ id: " + id + ", name: " + name + "}"
