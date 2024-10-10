extends CharacterBody2D
class_name SurvivalHero

@export_category("General")
@export var speed: float = 600
@export var xp_magnet_radius = 500

@onready var camera: Camera2D = %Camera2D
@onready var cosmetics: CharacterCosmetics = %HeroCosmetics
@onready var health_component: HealthComponent = %HealthComponent
@onready var hitbox_component: HitboxComponent = %HitboxComponent
@onready var xp_magnet_component: XPMagnetComponent = %XPMagnetComponent
@onready var pickup_area_component: PickupAreaComponent = %PickupAreaComponent
@onready var stats_component: SurvivalHeroStatsComponent = %SurvivalHeroStatsComponent
@onready var leveling_component: SurvivalHeroLevelingComponent = %SurvivalHeroLevelingComponent
@onready var level_up_component: SurvivalHeroLevelUpComponent = %SurvivalHeroLevelUpComponent
@onready var weapons_component: SurvivalHeroWeaponsComponent = %SurvivalHeroWeaponsComponent
@onready var upgrades_component: SurvivalHeroUpgradesComponent = %SurvivalHeroUpgradesComponent


func initialize(hero: Hero):
	stats_component.initialize(hero)
	health_component.initialize(hero.max_hp, hero.current_hp)
	weapons_component.initialize(stats_component)
	cosmetics.initialize(hero.sprite_id)


func _ready() -> void:
	xp_magnet_component.set_radius(xp_magnet_radius)


func _physics_process(_delta: float):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * (speed + (speed / 100 * stats_component.speed_modifier)) 
	move_and_slide()
	cosmetics.play_movement_animations(velocity)


func _on_hitbox_component_got_hit(attack: Attack) -> void:
	health_component.take_damage(attack.damage)
	SurvivalEventBus.HERO_HP_CHANGE.emit(health_component.get_health())
	cosmetics.play_hurt()


func _on_health_component_health_depleted() -> void:
	cosmetics.play_dead()


func _on_cosmetics_death_finished() -> void:
	var camera_position = camera.global_position
	remove_child(camera)
	get_parent().add_child(camera)
	camera.global_position = camera_position
	SurvivalEventBus.HERO_DEATH.emit()
	queue_free()


func _on_stats_changed(stats: SurvivalHeroStatsComponent) -> void:
	health_component.set_max_health(stats.max_hp)
	xp_magnet_component.set_pct_radius_modifier(stats.xp_magnet_area_modifier)
