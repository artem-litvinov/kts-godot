extends Area2D
class_name XPMagnetComponent

var _default_radius: float
var _radius: float


func _ready() -> void:
	_default_radius = %CollisionShape2D.shape.radius
	_radius = _default_radius


func get_radius() -> float:
	return _radius


func set_radius(radius: float) -> void:
	_radius = radius
	%CollisionShape2D.shape.radius = _radius


func set_pct_radius_modifier(pct_modifier: float) -> void:
	var _radius_increase = (_default_radius / 100) * pct_modifier
	_radius = _default_radius + _radius_increase
	%CollisionShape2D.shape.radius = _radius


func _on_area_entered(area: Area2D) -> void:
	if area is SurvivalXPDropInstance:
		area.magnetize()
