extends Node

signal HERO_DEATH
signal HERO_HP_CHANGE(health: float)
signal HERO_MAX_MAX_HP_CHANGE(max_health: float)
signal HERO_XP_CHANGE(xp: int)
signal HERO_LEVEL_UP(level: int, xp_to_next_level: int)
signal EARLY_EXIT_PORTAL_ENTERED
signal GAME_TIMER_REACHED_ZERO
