extends HBoxContainer

@export var Name: String
@export var Value: String


func _ready() -> void:
	%StatName.text = Name
	%StatValue.text = Value


func set_stat_name(name: String) -> void:
	Name = name
	%StatName.text = Name


func set_stat_value(value: String) -> void:
	Value = value
	%StatValue.text = value
