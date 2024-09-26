extends Node2D
class_name EnemySpawner

@export var spawn_path: PathFollow2D
@export var configs_per_minute: Array[EnemySpawnMinuteConfig]

var current_minute: int = 0
var enemy_spawn_timers: Array[Timer]


func _ready():
	_start_spawners()


func _start_spawners():
	var current_config: EnemySpawnMinuteConfig

	if current_minute < configs_per_minute.size():
		current_config = configs_per_minute[current_minute]
	else:
		# Use the last config if beyond defined configs
		current_config = configs_per_minute[configs_per_minute.size() - 1]

	for config in current_config.enemy_configs:
		var interval = 1.0 / config.number_per_second
		var spawn_timer = Timer.new()
		spawn_timer.set_wait_time(interval)
		spawn_timer.connect("timeout", _spawn_enemy.bind(config.enemy_scene))
		add_child(spawn_timer)
		spawn_timer.start()
		enemy_spawn_timers.append(spawn_timer)


func _spawn_enemy(enemy_scene: PackedScene):
	if not spawn_path:
		return

	var enemy_instance = enemy_scene.instantiate()
	spawn_path.progress_ratio = randf()
	enemy_instance.global_position = spawn_path.global_position
	get_parent().add_child(enemy_instance)


func _on_minute_passed():
	current_minute += 1
	_clear_timers()
	_start_spawners()


func _clear_timers():
	for timer in enemy_spawn_timers:
		timer.queue_free()
	enemy_spawn_timers.clear()
