extends Area2D

class_name DamageAreaComponent

# Settings
var _cooldown_sec: float
var _attack: Attack

# State
var _in_cooldown: bool = false
var _remaining_cooldown: float = 0
var _hitboxes_within_area: Array[HitboxComponent]


func initialize(cooldown_sec: float, attack: Attack) -> void:
	_cooldown_sec = cooldown_sec
	_attack = attack


func _physics_process(delta: float) -> void:
	if _in_cooldown:
		_remaining_cooldown -= delta
		if _remaining_cooldown <= 0:
			_in_cooldown = false
			_remaining_cooldown = 0
		return

	if _hitboxes_within_area.size() < 1:
		return

	_attack.position = global_position
	for hitbox in _hitboxes_within_area:
		hitbox.hit(_attack)

	_in_cooldown = true
	_remaining_cooldown = _cooldown_sec


func _on_area_entered(area: Area2D) -> void:
	if area is HitboxComponent:
		_hitboxes_within_area.append(area)


func _on_area_exited(area: Area2D) -> void:
	if area is HitboxComponent:
		_hitboxes_within_area.erase(area)
