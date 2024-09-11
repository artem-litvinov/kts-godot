extends Control

signal	button_pressed

@export var header_text: String
@export var description_text: String
@export var button_text: String
@export var backgroung_texture: Texture

var _mouse_in: bool


func _ready():
	%DescriptionContainer.modulate.a = 0
	%HeaderText.text = header_text
	%DescriptionText.text = description_text
	%Button.text = button_text
	%Background.texture = backgroung_texture


func _on_container_mouse_entered() -> void:
	if !_mouse_in:
		%AnimationPlayer.play("fade_in")
		_mouse_in = true


func _on_container_mouse_exited() -> void:
	if not Rect2(Vector2(), size).has_point(get_local_mouse_position()):
		%AnimationPlayer.play("fade_out")
		_mouse_in = false


func _on_button_pressed() -> void:
	button_pressed.emit()
