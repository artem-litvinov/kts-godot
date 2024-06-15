extends CharacterBody2D

const speed = 300  # Movement speed
const random_destination_chance = 0.5  # 50% chance to move to a random point
const threshold_distance = 100 # Threshold distance to consider the target reached

var buildings: Array[Node] = []

@onready var navigation_agent: NavigationAgent2D = %NavigationAgent2D


func _ready() -> void:
	# Dynamically find all buildings in the "buildings" group
	buildings = get_tree().get_nodes_in_group("buildings")
	%Slime.play_walk()

	call_deferred("setup_hero")

func setup_hero():
	# Wait for the first physics frame so the NavigationServer can sync.
	await get_tree().physics_frame
	set_new_target()


func _physics_process(_delta: float) -> void:
	if navigation_agent.is_navigation_finished():
		set_new_target()
		return
	move_towards_target()


func set_new_target() -> void:
	var new_target: Vector2
	if randf() < random_destination_chance:
		# Move to a random point on the map
		new_target = get_random_point()
	else:
		# Move to a random building
		var random_building = buildings[randi() % buildings.size()]
		new_target = random_building.position + Vector2(0, 60)
	navigation_agent.set_target_position(new_target)


func get_random_point() -> Vector2:
	var screen_size = get_viewport_rect().size 
	return Vector2(randf() * screen_size.x, randf() * screen_size.y)


func move_towards_target() -> void:
	var direction = global_position.direction_to(navigation_agent.get_next_path_position())
	navigation_agent.set_velocity(direction * speed)


func _on_navigation_agent_2d_velocity_computed(safe_velocity: Vector2) -> void:
	velocity = safe_velocity
	move_and_slide()
