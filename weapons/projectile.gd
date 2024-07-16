extends Node2D
class_name Projectile

@export var hitbox: Area2D

var weapon_stats: SurvivalWeaponStats

var _hits_left: int
var _travel_distance: float


func _ready() -> void:
	_hits_left = weapon_stats.piercing
	hitbox.area_entered.connect(_on_area_entered)


func _physics_process(delta: float) -> void:
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * weapon_stats.projectile_speed * delta

	_travel_distance += weapon_stats.projectile_speed * delta
	if _travel_distance > weapon_stats.range:
		queue_free()


func _on_area_entered(area: Area2D) -> void:
	if area is HitboxComponent:
		area.hit(Attack.from_params(
			weapon_stats.damage,
			weapon_stats.knockback,
			global_position,
			weapon_stats.stun_time,
		))
		if _hits_left > 0:
			_hits_left -= 1
		else:
			queue_free()
