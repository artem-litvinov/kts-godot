extends Control

const EXPAND_SHRINK_END: int = 10
const EXPAND_SHRINK_BEGIN: int = 2

var _message_text: String
var _own_message: bool

@onready var label = %Label
@onready var bubble_texture: PanelContainer = %BubbleTexture


func _ready():
	%Label.text = _message_text
	if _own_message:
		bubble_texture.set_h_size_flags(EXPAND_SHRINK_END)
		#bubble_texture.set_h_size_flags(Control.SIZE_EXPAND)
	else:
		bubble_texture.set_h_size_flags(EXPAND_SHRINK_BEGIN)
		#bubble_texture.set_h_size_flags(Control.SIZE_EXPAND)

func initialize(message: String, own_message: bool):
	_message_text = message
	_own_message = own_message
