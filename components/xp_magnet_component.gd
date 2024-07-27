extends Area2D
class_name XPMagnetComponent

@onready var _radius: int = %CollisionShape2D.shape.radius


func set_radius(radius: int) -> void:
	_radius = radius
	%CollisionShape2D.shape.radius = radius


func _on_area_entered(area: Area2D) -> void:
	if area is XPDropInstance:
		area.magnetize()
