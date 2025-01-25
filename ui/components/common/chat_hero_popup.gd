extends VBoxContainer

@onready var chat_area = $ScrollContainer/ChatArea
@onready var input_field = $InputArea/TextEdit

func _ready():
	$InputArea/Button.pressed.connect(_on_send_message)

func _on_send_message():
	var user_message = input_field.text.strip_edges()
	if user_message == "":
		return  # Prevent sending empty messages

	# Add user bubble
	_add_chat_bubble(user_message, "right")

	# Simulate AI response from backend
	_simulate_ai_response(user_message)

	input_field.text = ""  # Clear the input field after sending the message
	

func _simulate_ai_response(user_message: String) -> void:
	# Simulate a backend delay using a coroutine
	await get_tree().create_timer(1.0).timeout  # Simulate 1-second delay
	var ai_response = "This is a response to: '%s'" % user_message
	_add_chat_bubble(ai_response, "left")
	# Ensure we scroll to the bottom after the response
	_scroll_to_bottom()
	

func _add_chat_bubble(message: String, alignment: String):
	var bubble = preload("res://ui/components/common/chat_bubble.tscn").instantiate()
	bubble.set_message(message)
	bubble.alignment = alignment
	chat_area.add_child(bubble)

# Call adjust_alignment to apply the alignment immediately
	bubble.adjust_alignment()

	# Adjust alignment for "right" (user) or "left" (AI/hero)
	if alignment == "right":
		bubble.alignment = "right"
	else:
		bubble.alignment = "left"

func _scroll_to_bottom():
	# Use call_deferred to ensure UI updates before scrolling
	call_deferred("_deferred_scroll_to_bottom")

func _deferred_scroll_to_bottom():
	var scroll_bar = $ScrollContainer.get_v_scroll_bar()
	if scroll_bar:
		scroll_bar.value = scroll_bar.max_value
