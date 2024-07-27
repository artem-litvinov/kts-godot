extends CharacterBody2D

@export_category("General")
@export var speed: float = 600

@onready var camera: Camera2D = %Camera2D
@onready var cosmetics: CharacterCosmetics = %HeroCosmetics
@onready var health_component: HealthComponent = %HealthComponent
@onready var hitbox_component: HitboxComponent = %HitboxComponent
@onready var leveling_component: LevelingComponent = %LevelingComponent
@onready var xp_magnet_component: XPMagnetComponent = %XPMagnetComponent
@onready var pickup_area_component: PickupAreaComponent = %PickupAreaComponent


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


func _on_hitbox_component_got_hit(attack: Attack) -> void:
	health_component.take_damage(attack.damage)
	cosmetics.play_hurt()


func _on_health_component_health_depleted() -> void:
	cosmetics.play_dead()


func _on_cosmetics_death_finished() -> void:
	remove_child(camera)
	get_tree().root.add_child(camera)
	queue_free()


func _on_leveled_up(current_level: int) -> void:
	print("level up ", current_level)
