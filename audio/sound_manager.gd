extends Node

# Singleton instance
static var instance: SoundManager = null

var sound_wave_by_name: Dictionary = {}
var sound_pool_by_name: Dictionary = {}

func _ready():
	if instance:
		print("Warning: SoundManager instance already exists.")
	else:
		instance = self

# Adds a sound wave to the manager
func add_sound_wave(wave_name: String, wave: SoundWave):
	sound_wave_by_name[wave_name] = wave

# Adds a sound pool to the manager
func add_sound_pool(pool_name: String, pool: SoundPool):
	sound_pool_by_name[pool_name] = pool

# Plays a sound wave by name
func play_wave(wave_name: String):
	if wave_name in sound_wave_by_name:
		sound_wave_by_name[wave_name].play_sound()
	else:
		print("Sound wave not found: ", wave_name)

# Plays a sound from a pool by name
func play_pool(pool_name: String):
	if pool_name in sound_pool_by_name:
		sound_pool_by_name[pool_name].play_random_sound()
	else:
		print("Sound pool not found: ", pool_name)
