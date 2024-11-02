extends ProgressBar
class_name UIProgressBarComponent

@export var background_style: StyleBoxFlat
@export var fill_style: StyleBoxFlat


func _ready() -> void:
	if background_style:
		add_theme_stylebox_override("background", background_style)
	if fill_style:
		add_theme_stylebox_override("fill", fill_style)


func initialize(_max_value, _value) -> void:
	max_value = _max_value
	value = _value


func set_max_value(_max_value):
	max_value = _max_value


func set_current_value(_value):
	value = _value
