extends Resource

class_name User

var id: String
var name: String


func _to_string():
	return "User: " + name + " (" + id + ")"


static func from_json(json: Dictionary) -> User:
	var user = User.new()

	for param in json.keys():
		if param in user:
			user.set(param, json[param])
		else:
			return null

	return user


static func from_params(_id: String, _name: String) -> User:
	var user = User.new()
	user.id = _id
	user.name = _name
	return user
