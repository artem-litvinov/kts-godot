extends Node2D
class_name SurvivalHeroStatsComponent

signal stats_changed(stats: SurvivalHeroStatsComponent)

@export_category("General")
@export var max_hp: int
@export var speed_modifier: float
@export var xp_magnet_area_modifier: float

@export_category("Weapons")
@export var damage: int
@export var damage_modifier: float
@export var knockback_modifier: float
@export var cooldown_modifier: float
@export var reach_modifier: float
@export var piercing_modifier: int
@export var projectile_count_modifier: int
@export var projectile_speed_modifier: float


func initialize(hero: Hero) -> void:
	max_hp = hero.max_hp
	damage = hero.attack


func apply_permanent_modifier(modifier: SurvivalHeroStatsModifier) -> void:
	max_hp += modifier.max_hp
	speed_modifier += modifier.speed_modifier
	xp_magnet_area_modifier += modifier.xp_magnet_area_modifier

	damage += modifier.damage
	damage_modifier += modifier.damage_modifier
	knockback_modifier += modifier.knockback_modifier
	cooldown_modifier += modifier.cooldown_modifier
	reach_modifier += modifier.reach_modifier
	piercing_modifier += modifier.piercing_modifier
	projectile_count_modifier += modifier.projectile_count_modifier
	projectile_speed_modifier += modifier.projectile_speed_modifier
	
	stats_changed.emit(self)
