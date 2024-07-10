extends CharacterBody2D


func initialize(hero: Hero):
	%HeroCosmetics.setup_cosmetics(hero.sprite_id)


func _physics_process(_delta: float):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * 600
	move_and_slide()
	_update_animations()


func _update_animations() -> void:
	var moving_right = velocity.x > 0
	if velocity.length() > 0:
		%HeroCosmetics.play_running(moving_right)
	else:
		%HeroCosmetics.play_idle()
