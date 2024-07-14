extends CharacterBody2D

class_name SurvivalFollowerEnemy

@export_category("General")
@export var max_hp: float
@export var speed: float

@export_category("Area Attack")
@export var area_damage: float
@export var area_knockback_force: float
@export var area_stun_time: float

@export_category("Components")
@export var cosmetics: CharacterCosmetics
@export var health_component: HealthComponent
@export var hitbox_component: HitboxComponent

var _player: CharacterBody2D
var _hitboxes_within_damage_area: Array[HitboxComponent]


func _ready() -> void:
	_player = get_tree().get_first_node_in_group("player")


func _physics_process(_delta: float):
	if !_player:
		return

	_deal_area_attack()

	var direction = global_position.direction_to(_player.global_position)
	velocity = direction * speed
	move_and_slide()
	_update_animations()


func _deal_area_attack() -> void:
	var attack = _build_area_attack(global_position)
	for hitbox in _hitboxes_within_damage_area:
		hitbox.hit(attack)


func _build_area_attack(attack_position: Vector2) -> Attack:
	return Attack.from_params(
		area_damage,
		area_knockback_force,
		attack_position,
		area_stun_time,
	)


func _update_animations() -> void:
	if velocity.length() > 0:
		var moving_right = velocity.x > 0
		cosmetics.play_running(moving_right)
	else:
		cosmetics.play_idle()


func _on_hitbox_component_got_hit(attack: Attack) -> void:
	health_component.take_damage(attack.damage)
	velocity = (global_position - attack.position).normalized() * attack.knockback_force
	cosmetics.play_hurt()


func _on_health_component_health_depleted() -> void:
	cosmetics.play_dead(_on_death_finished)


func _on_death_finished() -> void:
	queue_free()


func _on_damage_area_entered(area: Area2D) -> void:
	if area is HitboxComponent:
		_hitboxes_within_damage_area.append(area)
