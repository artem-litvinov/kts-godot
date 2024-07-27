extends Area2D
class_name XPMagnetComponent


func set_radius(radius: int) -> void:
	%CollisionShape2D.shape.radius = radius


func _on_area_entered(area: Area2D) -> void:
	if area is XPDropInstance:
		area.magnetize()
