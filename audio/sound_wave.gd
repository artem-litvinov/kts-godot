extends Node

class_name SoundWave

@export var player_count: int = 1  # Number of AudioStreamPlayers to create

var players: Array[AudioStreamPlayer] = []
var current_player_index: int = 0

func _ready():
	# Find existing AudioStreamPlayer children
	for child in get_children():
		if child is AudioStreamPlayer:
			players.append(child)

func _get_configuration_warnings():
	if players.size() == 0:
		return ["No AudioStreamPlayer instances found. Please adjust the player_count."]
	return []

func play_sound():
	if players.size() == 0:
		return # Exit if no players are available
	
	# Select the current player
	var current_player = players[current_player_index]

	# Play sound if the current player is not already playing
	if not current_player.playing:
		print("Current player is not playing. Attempting to play...")
		current_player.play()
		print("Sound playback initiated.")
	
	print("AudioStreamPlayer state: playing =", current_player.playing, ", paused =", current_player.stream_paused)

	current_player_index = (current_player_index + 1) % players.size()
	print("Next player index: ", current_player_index)
