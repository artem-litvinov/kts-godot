extends Button
class_name EventOptionButton

const MAX_CHAR_PER_LINE = 50


# Function to wrap text by inserting '\n' after every MAX_CHAR_PER_LINE characters
func autowrap_text(_text: String) -> String:
	var wrapped_text = ""
	var current_line_length = 0

	var words = _text.split(" ")
	for word in words:
		# If adding the next word would exceed the limit, insert a newline
		if current_line_length + word.length() > MAX_CHAR_PER_LINE:
			wrapped_text += "\n"
			current_line_length = 0

		# Add the word to the current line
		wrapped_text += word + " "
		current_line_length += word.length() + 1  # +1 for the space

	# Remove trailing space at the end of the text
	return wrapped_text.strip_edges()


# Function to set the text of a Label with auto-wrapping
func set_text_autowrap(_text: String) -> void:
	var wrapped_text = autowrap_text(_text)
	self.text = wrapped_text
