extends HBoxContainer

@export var icon: Texture


func _ready() -> void:
	%TextureRect.texture = icon


func update_value(value: int) -> void:
	%Label.text = str(value)
