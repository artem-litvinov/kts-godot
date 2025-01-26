extends VBoxContainer

@onready var chat_area = $ScrollContainer/ChatArea
@onready var input_field = $InputArea/TextEdit
var max_scroll_length = 0
@onready var scroll_container: ScrollContainer = %ScrollContainer
@onready var scrollbar = scroll_container.get_v_scroll_bar()

func _ready():
	$InputArea/Button.pressed.connect(_on_send_message)
	scrollbar.changed.connect(handle_scrollbar_changed)
	max_scroll_length = scrollbar.max_value

func _on_send_message():
	var user_message = input_field.text.strip_edges()
	if user_message == "":
		return  # Prevent sending empty messages

	# Add user bubble
	_add_chat_bubble(user_message, true)

	# Simulate AI response from backend
	_simulate_ai_response(user_message)

	input_field.text = ""  # Clear the input field after sending the message
	

func _simulate_ai_response(user_message: String) -> void:
	# Simulate a backend delay using a coroutine
	await get_tree().create_timer(1.0).timeout  # Simulate 1-second delay
	var ai_response = "This is a response to: '%s'" % user_message
	_add_chat_bubble(ai_response, false)
	# Ensure we scroll to the bottom after the response
	
func _add_chat_bubble(message: String, own_message: bool):
	var bubble = preload("res://ui/components/common/chat_bubble.tscn").instantiate()
	bubble.initialize(message, own_message)
	chat_area.add_child(bubble)

func handle_scrollbar_changed(): 
	if max_scroll_length != scrollbar.max_value: 
		max_scroll_length = scrollbar.max_value 
	scroll_container.scroll_vertical = max_scroll_length
