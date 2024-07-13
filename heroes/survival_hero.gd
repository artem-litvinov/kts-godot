extends CharacterBody2D


@export var speed: float = 600


func initialize(hero: Hero):
	%HeroCosmetics.setup_cosmetics(hero.sprite_id)


func _physics_process(_delta: float):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * speed
	move_and_slide()
	_update_animations()


func _update_animations() -> void:
	if velocity.length() > 0:
		var moving_right = velocity.x > 0
		%HeroCosmetics.play_running(moving_right)
	else:
		%HeroCosmetics.play_idle()


func _on_hitbox_component_got_hit(attack: Variant) -> void:
	%HealthComponent.take_damage(attack.damage)


func _on_health_component_health_depleted() -> void:
	pass # Replace with function body.
