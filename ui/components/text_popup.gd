extends Control

signal button_pressed


func set_header_text(text: String) -> void:
	%HeaderText.text = text


func set_body_text(text: String) -> void:
	%BodyText.text = text


func set_button_text(text: String) -> void:
	%Button.text = text.capitalize()


func disable_button() -> void:
	%Button.disabled = true


func _on_button_pressed() -> void:
	button_pressed.emit()
