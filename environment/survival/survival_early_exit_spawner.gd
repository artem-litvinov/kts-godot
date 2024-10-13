extends Node2D
class_name SurvivalEarlyExitSpawner

@export_category("Setup")
@export var spawn_path: PathFollow2D
@export var early_exit_portal_scene: PackedScene

@export_category("Config")
@export var timer_sec: int = 180
@export var portal_ttl_sec: int = 60

@onready var timer: Timer = $Timer


func _ready():
	timer.wait_time = timer_sec
	timer.start()


func _spawn_portal():
	if not spawn_path:
		return

	var portal: SurvivalEarlyExitPortal = early_exit_portal_scene.instantiate()
	portal.initialize(portal_ttl_sec)
	spawn_path.progress_ratio = randf()
	portal.global_position = spawn_path.global_position
	get_parent().add_child.call_deferred(portal)


func _on_timer_timeout() -> void:
	_spawn_portal()
