extends Control
class_name UISurvivalExitScreen

signal exit


func initialize(is_alive: bool) -> void:
	if is_alive:
		%Header.text = Strings.SURVIVAL_EXIT_HEADER_ALIVE
	else:
		%Header.text = Strings.SURVIVAL_EXIT_HEADER_DEAD


func _on_button_pressed() -> void:
	exit.emit()
