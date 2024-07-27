extends CharacterBody2D
class_name SurvivalFollowerEnemy

const XP_DROP_SCENE = preload("res://enemies/xp_drop.tscn")

@export_category("General")
@export var max_hp: float
@export var speed: float
@export var xp_drop: XPDrop

@export_category("Area Attack")
@export var area_attack_cooldown_sec: float
@export var area_damage: float
@export var area_knockback_force: float
@export var area_stun_time: float

@export_category("Components")
@export var cosmetics: CharacterCosmetics
@export var health_component: HealthComponent
@export var hitbox_component: HitboxComponent
@export var damage_area_component: DamageAreaComponent

var _player: CharacterBody2D
var _knockback: Vector2 = Vector2.ZERO
var _is_dead: bool = false


func _ready() -> void:
	_player = get_tree().get_first_node_in_group("player")
	health_component.initialize(max_hp)
	damage_area_component.initialize(
		area_attack_cooldown_sec,
		Attack.from_params(
			area_damage,
			area_knockback_force,
			global_position,
			area_stun_time,
		),
	)


func _physics_process(_delta: float):
	if _is_dead:
		return

	var direction = Vector2.ZERO

	if _player:
		direction = global_position.direction_to(_player.global_position)

	velocity = direction * speed + _knockback
	_knockback = lerp(_knockback, Vector2.ZERO, 0.1)
	move_and_slide()
	cosmetics.play_movement_animations(velocity)


func _on_hitbox_component_got_hit(attack: Attack) -> void:
	health_component.take_damage(attack.damage)
	_knockback = (global_position - attack.position).normalized() * attack.knockback_force
	cosmetics.play_hurt()


func _on_health_component_health_depleted() -> void:
	cosmetics.play_dead()
	_is_dead = true


func _on_cosmetics_death_finished() -> void:
	var drop_instance = XP_DROP_SCENE.instantiate()
	drop_instance.initialize(xp_drop)
	drop_instance.global_position = global_position
	get_parent().add_child(drop_instance)
	queue_free()
