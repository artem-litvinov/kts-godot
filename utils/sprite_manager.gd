extends Node

const _sprite_path_by_id = {
	# Heroes
	"amazon_warrior_1": "res://sprites/amazon_warrior_1/",
	"amazon_warrior_2": "res://sprites/amazon_warrior_2/",
	"amazon_warrior_3": "res://sprites/amazon_warrior_3/",
	"anubis": "res://sprites/anubis/",
	"archer_1": "res://sprites/archer_guy/",
	"assassin_guy": "res://sprites/assassin_guy/",
	"barbarian_warrior": "res://sprites/barbarian_warrior/",
	"black_ninja": "res://sprites/black_ninja/",
	"black_wizard": "res://sprites/black_wizard/",
	"blacksmith_guy": "res://sprites/blacksmith_guy/",
	"chibi_prisoner_guy": "res://sprites/chibi_prisoner_guy/",
	"citizen_1": "res://sprites/citizen_1/",
	"citizen_2": "res://sprites/citizen_2/",
	"citizen_3": "res://sprites/citizen_3/",
	"citizen-women_1": "res://sprites/citizen_women_1/",
	"citizen-women_2": "res://sprites/citizen_women_2/",
	"citizen-women_3": "res://sprites/citizen_women_3/",
	"dark_elves_1": "res://sprites/dark_elf_1/",
	"dark_elves_2": "res://sprites/dark_elf_2/",
	"dark_elves_3": "res://sprites/dark_elf_3/",
	"devil_masked_guy": "res://sprites/devil_masked_guy/",
	"egyptian_mummy": "res://sprites/egyptian_mummy/",
	"egyptian_sentry": "res://sprites/egyptian_sentry/",
	"elf_archer_1": "res://sprites/archer_1/",
	"elf_archer_2": "res://sprites/archer_2/",
	"elf_archer_3": "res://sprites/archer_3/",
	"fallen_angels_1": "res://sprites/fallen_angel_1/",
	"fallen_angels_2": "res://sprites/fallen_angel_2/",
	"fallen_angels_3": "res://sprites/fallen_angel_3/",
	"gnome_1": "res://sprites/gnome_1/",
	"gnome_2": "res://sprites/gnome_2/",
	"gnome_3": "res://sprites/gnome_3/",
	"knight_1": "res://sprites/knight_1/",
	"knight_2": "res://sprites/knight_2/",
	"knight_3": "res://sprites/knight_3/",
	"medieval_commander": "res://sprites/medieval_commander/",
	"medieval_hooded_girl": "res://sprites/medieval_hooded_girl/",
	"medieval_king": "res://sprites/medieval_king/",
	"medieval_knight": "res://sprites/medieval_knight/",
	"medieval_mage": "res://sprites/medieval_mage/",
	"medieval_sergeant": "res://sprites/medieval_sergeant/",
	"medieval_thug": "res://sprites/medieval_thug/",
	"medieval_warrior_girl": "res://sprites/medieval_warrior_girl/",
	"medieval_warrior": "res://sprites/medieval_warrior/",
	"medusa_1": "res://sprites/medusa_1/",
	"medusa_2": "res://sprites/medusa_2/",
	"medusa_3": "res://sprites/medusa_3/",
	"persian_and_arab_warriors_1": "res://sprites/persian_warrior_1/",
	"persian_and_arab_warriors_2": "res://sprites/persian_warrior_2/",
	"persian_and_arab_warriors_3": "res://sprites/persian_warrior_3/",
	"pyromancer_1": "res://sprites/pyromancer_1/",
	"pyromancer_2": "res://sprites/pyromancer_2/",
	"pyromancer_3": "res://sprites/pyromancer_3/",
	"romanian_settler": "res://sprites/romanian_settler/",
	"shaman_2": "res://sprites/shaman_2/",
	"shaman_3": "res://sprites/shaman_3/",
	"shamans_1": "res://sprites/shaman_1/",
	"templar_knight": "res://sprites/templar_knight/",
	"very_heavy_armored_frontier_defender": "res://sprites/very_heavy_armored_frontier_defender/",
	"viking_1": "res://sprites/viking_1/",
	"viking_2": "res://sprites/viking_2/",
	"viking_3": "res://sprites/viking_3/",
	"villager_1": "res://sprites/villager_1/",
	"villager_2": "res://sprites/villager_2/",
	"villager_3": "res://sprites/villager_3/",
	"white_armored_knight": "res://sprites/white_armored_knight/",
	"white_ninja": "res://sprites/white_ninja/",
	"witch_1": "res://sprites/witch_1/",
	"witch_2": "res://sprites/witch_2/",
	"witch_3": "res://sprites/witch_3/",

	# Enemies
	"flying_monster_1": "res://sprites/flying_monster_1/",
	"flying_monster_2": "res://sprites/flying_monster_2/",
	"flying_monster_3": "res://sprites/flying_monster_3/",
	"flying_monster_4": "res://sprites/flying_monster_4/",
	"regular_skeleton_1": "res://sprites/regular_skeleton_1/",
	"regular_skeleton_2": "res://sprites/regular_skeleton_2/",
	"regular_skeleton_3": "res://sprites/regular_skeleton_3/",
	"skull_1": "res://sprites/skull_1/",
	"skull_2": "res://sprites/skull_2/",
	"skull_3": "res://sprites/skull_3/",
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
