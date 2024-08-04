extends Node2D
class_name SurvivalProjectile

@export var hitbox: Area2D

var _hero_stats: SurvivalHeroStatsComponent
var _weapon_stats: SurvivalWeaponStats
var _hits_left: int
var _travel_distance: float


func initialize(hero_stats: SurvivalHeroStatsComponent, weapon_stats: SurvivalWeaponStats) -> void:
	_hero_stats = hero_stats
	_weapon_stats = weapon_stats


func _ready() -> void:
	_hits_left = _weapon_stats.piercing + _hero_stats.piercing_modifier
	hitbox.area_entered.connect(_on_area_entered)


func _physics_process(delta: float) -> void:
	var direction = Vector2.RIGHT.rotated(rotation)
	var speed_increase = _weapon_stats.projectile_speed / 100 * _hero_stats.projectile_speed_modifier
	var speed = _weapon_stats.projectile_speed + speed_increase
	position += direction * speed * delta

	_travel_distance += _weapon_stats.projectile_speed * delta
	var reach_increase = (_weapon_stats.reach / 100) * _hero_stats.reach_modifier
	var final_reach = _weapon_stats.reach + reach_increase
	if _travel_distance > final_reach:
		queue_free()


func _on_area_entered(area: Area2D) -> void:
	if area is HitboxComponent:
		var dmg = _weapon_stats.damage + _hero_stats.damage
		var dmg_increase = (dmg / 100) * _hero_stats.damage_modifier
		var final_dmg = dmg + dmg_increase

		var knockback_increase = (_weapon_stats.knockback / 100) * _hero_stats.knockback_modifier
		var final_knockback = _weapon_stats.knockback + knockback_increase

		area.hit(Attack.from_params(
			final_dmg,
			final_knockback,
			global_position,
			_weapon_stats.stun_time,
		))
		if _hits_left > 0:
			_hits_left -= 1
		else:
			queue_free()
