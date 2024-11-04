extends Node
class_name SurvivalGameTimer

@export var time_till_end_sec: int

@onready var label: Label = %TimerLabel
@onready var time_left: float = time_till_end_sec


func _ready() -> void:
	set_process(true)


func _process(delta: float) -> void:
	if time_left > 0:
		time_left -= delta
		time_left = max(time_left, 0)
		update_timer_display()
	else:
		SurvivalEventBus.GAME_TIMER_REACHED_ZERO.emit()
		set_process(false)


func update_timer_display() -> void:
	var minutes: int = int(time_left) / 60
	var seconds: int = int(time_left) % 60
	label.text = "%02d:%02d" % [minutes, seconds]
