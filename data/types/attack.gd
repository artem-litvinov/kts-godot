extends Resource

class_name Attack

var damage: float
var knockback_force: float
var position: Vector2
var stun_time: float


static func from_params(
	_damage: float,
	_knockback_force: float,
	_position: Vector2,
	_stun_time: float,
) -> Attack:
	var attack = Attack.new()

	attack.damage = _damage
	attack.knockback_force = _knockback_force
	attack.position = _position
	attack.stun_time = _stun_time

	return attack
