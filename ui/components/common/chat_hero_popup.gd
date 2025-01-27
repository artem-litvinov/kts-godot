extends VBoxContainer

@onready var chat_area = %ChatArea
@onready var input_field = %TextEdit
@onready var scroll_container: ScrollContainer = %ScrollContainer
@onready var scrollbar = scroll_container.get_v_scroll_bar()

var max_scroll_length = 0
@export var hero_id: String = ""

func _ready():
	%Button.pressed.connect(_on_send_message)
	scrollbar.changed.connect(handle_scrollbar_changed)
	max_scroll_length = scrollbar.max_value

func initialize(id: String) -> void:
	hero_id = id.strip_edges()

func _on_send_message():
	var user_message = input_field.text.strip_edges()
	if user_message.is_empty() or hero_id.is_empty():
		return
		
	_add_chat_bubble(user_message, true)
	input_field.editable = false
	
	var err = BackendAPI.chat_with_hero(hero_id, user_message, _on_chat_response)
	if err != OK:
		_add_chat_bubble("Sorry, there was an error sending your message.", false)
		input_field.editable = true

	input_field.text = ""

func _on_chat_response(response, error: int):
	input_field.editable = true  # Re-enable input
	
	if error != OK:
		var error_message = "Sorry, there was an error getting a response."
		print("Chat error: ", error)  # Debug print
		_add_chat_bubble(error_message, false)
		return
		
	if response == null:
		var error_message = "Sorry, no response received."
		print("Chat error: null response")  # Debug print
		_add_chat_bubble(error_message, false)
		return
		
	_add_chat_bubble(str(response), false)  # Convert response to string explicitly

func _add_chat_bubble(message: String, own_message: bool):
	var bubble = preload("res://ui/components/common/chat_bubble.tscn").instantiate()
	bubble.initialize(message, own_message)
	chat_area.add_child(bubble)

func handle_scrollbar_changed(): 
	if max_scroll_length != scrollbar.max_value: 
		max_scroll_length = scrollbar.max_value 
	scroll_container.scroll_vertical = max_scroll_length
