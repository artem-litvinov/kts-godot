extends Node

class_name SoundPool

var sound_waves: Array[SoundWave] = []
var last_played_index: int = -1

func _ready():
	sound_waves = []
	for child in get_children():
		if child is SoundWave:
			sound_waves.append(child)

func _get_configuration_warnings():
	if sound_waves.size() < 2:
		return ["Expected two or more children of type SoundWave."]
	return []

func play_random_sound():
	var index = 0
	if sound_waves.size() > 1:
		index = randi() % sound_waves.size()
		while index == last_played_index:
			index = randi() % sound_waves.size()
	last_played_index = index
	sound_waves[index].play_sound()

	
