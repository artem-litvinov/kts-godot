extends Node2D
class_name UITargetReticles

@export var offscreen_reticle_offset: int = 100
@export var direction_line_size: int = 5000

var camera: Camera2D

@onready var offscreen_reticle: Node2D = $OffscreenReticle


func _ready() -> void:
	camera = get_viewport().get_camera_2d()
	offscreen_reticle.visible = false


func _process(_delta: float) -> void:
	if _is_position_in_camera():
		offscreen_reticle.visible = false
		return

	_show_offscreen_reticle()


func _is_position_in_camera() -> bool:
	var camera_rect = camera.get_viewport_rect()
	var half_size = camera_rect.size * 0.5

	# Get the camera's position in world space (this is the center of the camera's viewport)
	var camera_pos = camera.global_position

	# Calculate the boundaries of the camera's visible area in world space
	var left_bound = camera_pos.x - half_size.x
	var right_bound = camera_pos.x + half_size.x
	var top_bound = camera_pos.y - half_size.y
	var bottom_bound = camera_pos.y + half_size.y

	# Check if the position is within the camera's bounds
	return (
		global_position.x >= left_bound and
		global_position.x <= right_bound and
		global_position.y >= top_bound and
		global_position.y <= bottom_bound
	)


func _show_offscreen_reticle() -> void:
	var direction = camera.global_position.direction_to(global_position)

	var edge_pos = _get_intersection_with_camera_edges(direction)

	var direction_to_camera = edge_pos.direction_to(camera.global_position)
	var reticle_pos = edge_pos + direction_to_camera * offscreen_reticle_offset

	offscreen_reticle.global_position = reticle_pos
	offscreen_reticle.rotation = direction.angle()
	offscreen_reticle.visible = true


func _get_intersection_with_camera_edges(direction: Vector2) -> Vector2:
	var camera_pos = camera.global_position
	var camera_rect = camera.get_viewport_rect()
	var half_size = camera_rect.size * 0.5

	var top_left = camera_pos + Vector2(-half_size.x, -half_size.y)
	var top_right = camera_pos + Vector2(half_size.x, -half_size.y)
	var bottom_left = camera_pos + Vector2(-half_size.x, half_size.y)
	var bottom_right = camera_pos + Vector2(half_size.x, half_size.y)

	# Create lines for each edge of the screen
	var lines = [
		[top_left, top_right], # Top edge
		[top_right, bottom_right], # Right edge
		[bottom_right, bottom_left], # Bottom edge
		[bottom_left, top_left], # Left edge
	]

	# Create the direction vector as a line starting from the screen center
	var direction_line_start = camera_pos
	var direction_line_end = camera_pos + direction * direction_line_size

	# Check for intersection with each screen edge
	for line in lines:
		var intersection = Geometry2D.segment_intersects_segment(direction_line_start, direction_line_end, line[0], line[1])
		if intersection:
			return intersection

	return Vector2.ZERO
