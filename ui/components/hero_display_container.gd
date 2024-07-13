extends MarginContainer


func initialize(hero: Hero, compact: bool) -> void:
	%Name.text = hero.name
	%Tier.texture = load(SpriteManager.get_tier_sprite_path(hero.tier))
	%Gender.set_stat_value(str(Enums.Gender.keys()[hero.gender]))
	%Type.set_stat_value(str(Enums.HeroType.keys()[hero.type]))
	%Health.set_stat_value(str(hero.max_hp))
	%Attack.set_stat_value(str(hero.attack))
	%Bio.text = hero.bio
	%HeroCosmetics.initialize(hero.sprite_id)
	%HeroCosmetics.play_idle()

	if compact:
		%BioContainer.hide()
