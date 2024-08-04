extends Resource

class_name SurvivalWeapon

@export var id: String
@export var name: String
@export_multiline var description: String
@export var level: int = 0
@export var max_level: int = 8
@export var stats_per_level: Array[SurvivalWeaponStats]
@export var weapon_scene: PackedScene
@export var projectile_scene: PackedScene
