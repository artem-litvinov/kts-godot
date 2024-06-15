extends Node

# Dictionary to store SpriteID to sprite path mappings
const _sprite_mapping = {
	"Villager_1": "res://heroes/Villager_1/",
	"Villager_2": "res://heroes/Villager_2/",
	"Villager_3": "res://heroes/Villager_3/",
}

# Function to get the sprite path based on SpriteID
func get_sprite_path(sprite_id: String) -> String:
	if _sprite_mapping.has(sprite_id):
		return _sprite_mapping[sprite_id]
	else:
		return ""
