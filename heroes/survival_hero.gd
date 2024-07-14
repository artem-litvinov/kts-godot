extends CharacterBody2D

@export_category("General")
@export var speed: float = 600

@export_category("Components")
@export var cosmetics: CharacterCosmetics
@export var health_component: HealthComponent
@export var hitbox_component: HitboxComponent


func initialize(hero: Hero):
	cosmetics.initialize(hero.sprite_id)
	health_component.initialize(hero.current_hp)


func _physics_process(_delta: float):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * speed
	move_and_slide()
	_update_animations()


func _update_animations() -> void:
	if velocity.length() > 0:
		var moving_right = velocity.x > 0
		cosmetics.play_running(moving_right)
	else:
		cosmetics.play_idle()


func _on_hitbox_component_got_hit(attack: Variant) -> void:
	health_component.take_damage(attack.damage)
	cosmetics.play_hurt()
	print(health_component.get_health())


func _on_health_component_health_depleted() -> void:
	cosmetics.play_dead(_on_death_finished)


func _on_death_finished() -> void:
	queue_free()
