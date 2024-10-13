extends Node2D
class_name SurvivalEarlyExitPortal

var _ttl: int

@onready var timer: Timer = $Timer


func initialize(ttl: int) -> void:
	_ttl = ttl


func _ready() -> void:
	if _ttl:
		timer.wait_time = _ttl
		timer.start()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is SurvivalHero:
		SurvivalEventBus.EARLY_EXIT_PORTAL_ENTERED.emit()


func _on_timer_timeout() -> void:
	queue_free()
