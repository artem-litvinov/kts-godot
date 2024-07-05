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
var maxHP: int
var currentHP: int


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
	_maxHP: int,
	_currentHP: int
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
	hero.maxHP = _maxHP
	hero.currentHP = _currentHP
	return hero
