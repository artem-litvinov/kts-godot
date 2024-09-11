extends HBoxContainer
class_name UIHeroStatChangeContainer


func initialize(stat_name: String, delta: String, units: String) -> void:
	%Name.text = stat_name
	%Delta.text = delta
	%Units.text = units
