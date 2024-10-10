extends Control
class_name UISurvivalEarlyExitConfirmationPopup

signal selected(bool)


func _on_yes_pressed() -> void:
	selected.emit(true)


func _on_no_pressed() -> void:
	selected.emit(false)
