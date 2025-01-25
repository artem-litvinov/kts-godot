extends Control

@export var alignment: String = "left"  # "left" for AI, "right" for user
@onready var label = %Label
@onready var texture_rect = %TextureRect
var message_text: String

func _ready():
	adjust_alignment()
	%Label.text = message_text

func set_message(message: String):
	message_text = message
	
	if label:
		label.text = message  # Ensure the label is not null before setting text
	else:
		print("Label node is missing or not assigned.")

func adjust_alignment():
	if alignment == "right":
		# Align the chat bubble to the right
		texture_rect.anchor_left = 1.0
		texture_rect.anchor_right = 1.0
		texture_rect.offset_left = -1000  # Adjust offset for bubble width
		texture_rect.offset_right = 0
		label.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	else:
		# Align the chat bubble to the left
		texture_rect.anchor_left = 0.0
		texture_rect.anchor_right = 0.0
		texture_rect.offset_left = 0
		texture_rect.offset_right = 1000  # Adjust offset for bubble width
		label.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
