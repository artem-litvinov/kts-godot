extends HBoxContainer

@export var Name: String
@export var Value: String


func _ready() -> void:
	%StatName.text = Name
	%StatValue.text = Value


func set_stat_name(_name: String) -> void:
	Name = _name
	%StatName.text = Name


func set_stat_value(value: String) -> void:
	Value = value
	%StatValue.text = value
