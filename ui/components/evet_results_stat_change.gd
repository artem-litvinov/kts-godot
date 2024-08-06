extends HBoxContainer

@export var icon: Texture
@export var positive_color: Color
@export var negative_color: Color

func initialize(value: int, delta: int):
	var is_negative = delta < 0
	var color = negative_color if is_negative else positive_color
	var deltaText = "- %s" % -delta if is_negative else "+ %s" % delta
	var text = "%s (%s)" % [value, deltaText]
	%Label.add_theme_color_override("font_color", color)
	%Label.text = text

func _ready() -> void:
	%TextureRect.texture = icon
