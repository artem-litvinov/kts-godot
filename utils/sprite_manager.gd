extends Node

const _sprite_path_by_id = {
	"villager_1": "res://sprites/villager_1/",
	"villager_2": "res://sprites/villager_2/",
	"villager_3": "res://sprites/villager_3/",
	"flying_monster_1": "res://sprites/flying_monster_1/",
	"flying_monster_2": "res://sprites/flying_monster_2/",
	"flying_monster_3": "res://sprites/flying_monster_3/",
	"flying_monster_4": "res://sprites/flying_monster_4/",
}

const _tier_sprite_mapping = {
	Enums.HeroTier.S: "res://ui/assets/rpg_mmo_ui/Textures/Miscellaneous/Text Box Icons/Icon_Star.png",
	Enums.HeroTier.A: "res://ui/assets/rpg_mmo_ui/Textures/Miscellaneous/Text Box Icons/Icon_Symbol.png",
	Enums.HeroTier.B: "res://ui/assets/rpg_mmo_ui/Textures/Miscellaneous/Text Box Icons/Icon_Circle.png",
}


func get_sprite_path(sprite_id: String) -> String:
	if _sprite_path_by_id.has(sprite_id):
		return _sprite_path_by_id[sprite_id]
	else:
		return ""


func get_tier_sprite_path(tier: Enums.HeroTier):
	if _tier_sprite_mapping.has(tier):
		return _tier_sprite_mapping[tier]
	else:
		return ""
