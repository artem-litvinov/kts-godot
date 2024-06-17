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


func _init(
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
) -> void:
	id = _id
	name = _name
	gender = _gender
	type = _type
	tier = _tier
	bio = _bio
	sprite_id = _sprite_id
	attack = _attack
	maxHP = _maxHP
	currentHP = _currentHP
