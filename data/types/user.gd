extends Resource

class_name User

var name: String


func _to_string():
	return "User: " + name


static func from_json(json: Dictionary) -> User:
	var user = User.new()

	user.name = json["username"]

	return user


static func from_params(_name: String) -> User:
	var user = User.new()

	user.name = _name

	return user
