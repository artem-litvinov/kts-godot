extends Control

signal scavenge_mode_selected
signal survival_mode_selected
signal close


func _input(event):
	if event is InputEventMouseButton and event.pressed:
		if is_click_outside_panels(event.global_position):
			close.emit()


func is_click_outside_panels(cursor_position: Vector2) -> bool:
	for panel in [%ScavengeModePanel, %SurvivalModePanel]:
		var panel_rect = panel.get_global_rect()
		if panel_rect.has_point(cursor_position):
			return false
	return true


func _on_scavenge_mode_panel_button_pressed() -> void:
	scavenge_mode_selected.emit()


func _on_survival_mode_panel_button_pressed() -> void:
	survival_mode_selected.emit()
