extends Control

signal button_pressed


func set_text_content(header: String, body: String, button: String) -> void:
	reset()
	set_header_text(header)
	set_body_text(body)
	set_button_text(button)


func set_header_text(text: String) -> void:
	%HeaderText.text = text


func set_body_text(text: String) -> void:
	%BodyText.text = text


func set_button_text(text: String) -> void:
	%Button.text = text.capitalize()


func disable_button() -> void:
	%Button.disabled = true


func reset() -> void:
	%HeaderText.text = ""
	%BodyText.text = ""
	%Button.text = ""
	%Button.disabled = false


func _on_button_pressed() -> void:
	button_pressed.emit()
