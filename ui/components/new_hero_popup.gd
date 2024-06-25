extends Control

signal button_pressed


func initialize(hero: Hero) -> void:
	%Name.text = hero.name
	%Tier.texture = load(SpriteManager.get_tier_sprite_path(hero.tier))
	%Gender.set_stat_value(str(Enums.Gender.keys()[hero.gender]))
	%Type.set_stat_value(str(Enums.HeroType.keys()[hero.type]))
	%Health.set_stat_value(str(hero.maxHP))
	%Attack.set_stat_value(str(hero.attack))
	%Bio.text = hero.bio
	%HeroCosmetics.setup_cosmetics(hero.sprite_id)
	%HeroCosmetics.play_idle()


func _on_button_pressed() -> void:
	button_pressed.emit()
