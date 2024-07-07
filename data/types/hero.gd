extends Resource

class_name Hero

var id: String
var name: String
var gender: Enums.Gender
var type: Enums.HeroType
var tier: Enums.HeroTier
var bio: String
var sprite_id: String
var attack: int
var max_hp: int
var current_hp: int


func _to_string() -> String:
	return "Hero: " + name + " (" + id + ")"


static func from_json(json: Dictionary) -> Hero:
	var hero = Hero.new()

	for param in json.keys():
		if param in hero:
			hero.set(param, json[param])
		else:
			return null

	return hero


static func from_params(
	_id: String,
	_name: String,
	_gender: Enums.Gender,
	_type: Enums.HeroType,
	_tier: Enums.HeroTier,
	_bio: String,
	_sprite_id: String,
	_attack: int,
	_max_hp: int,
	_current_hp: int
) -> Hero:
	var hero = Hero.new()
	hero.id = _id
	hero.name = _name
	hero.gender = _gender
	hero.type = _type
	hero.tier = _tier
	hero.bio = _bio
	hero.sprite_id = _sprite_id
	hero.attack = _attack
	hero.max_hp = _max_hp
	hero.current_hp = _current_hp
	return hero
