extends Resource

class_name User

var id: String
var name: String


func _to_string():
	return "{ id: " + id + ", name: " + name + "}"


static func from_json(json: Dictionary) -> User:
	var user = User.new()

	for param in json.keys():
		if param in user:
			user.set(param, json[param])
		else:
			return null

	return user
