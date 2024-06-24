extends Node

const _hero_sprite_mapping = {
	"villager_1": "res://heroes/villager_1/",
	"villager_2": "res://heroes/villager_2/",
	"villager_3": "res://heroes/villager_3/",
}

const _tier_sprite_mapping = {
	Enums.HeroTier.S: "res://ui/assets/rpg_mmo_ui/Textures/Miscellaneous/Text Box Icons/Icon_Star.png",
	Enums.HeroTier.A: "res://ui/assets/rpg_mmo_ui/Textures/Miscellaneous/Text Box Icons/Icon_Symbol.png",
	Enums.HeroTier.B: "res://ui/assets/rpg_mmo_ui/Textures/Miscellaneous/Text Box Icons/Icon_Circle.png",
}

func get_hero_sprite_path(sprite_id: String) -> String:
	if _hero_sprite_mapping.has(sprite_id):
		return _hero_sprite_mapping[sprite_id]
	else:
		return ""

func get_tier_sprite_path(tier: Enums.HeroTier):
	if _tier_sprite_mapping.has(tier):
		return _tier_sprite_mapping[tier]
	else:
		return ""
