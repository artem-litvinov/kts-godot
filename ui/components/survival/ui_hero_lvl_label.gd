extends Label
class_name UIHeroLvlLabel

const prefix: String = "Lvl. "


func set_level(level: int) -> void:
	text = prefix + str(level)
