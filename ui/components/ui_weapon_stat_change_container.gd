extends HBoxContainer
class_name UIWeaponStatChangeContainer


func initialize(stat_name: String, before_value: String, after_value: String) -> void:
	%Name.text = stat_name
	%BeforeValue.text = before_value
	%AfterValue.text = after_value
