extends Node

# Dictionary to store SpriteID to sprite path mappings
const _sprite_mapping = {
	"villager_1": "res://heroes/villager_1/",
	"villager_2": "res://heroes/villager_2/",
	"villager_3": "res://heroes/villager_3/",
}

# Function to get the sprite path based on SpriteID
func get_sprite_path(sprite_id: String) -> String:
	if _sprite_mapping.has(sprite_id):
		return _sprite_mapping[sprite_id]
	else:
		return ""
