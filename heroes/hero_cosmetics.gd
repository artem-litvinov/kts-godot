extends Node2D

const IDLE_ANIM_NAME = "idle"
const RUNNING_ANIM_NAME = "running"
const SPRITE_FILE_EXT = ".png"

var sprites_path: String
var idle_anim_sprites
var running_anim_sprites


func setup_cosmetics(sprite_id: String) -> void:
	sprites_path = SpriteManager.get_hero_sprite_path(sprite_id)
	idle_anim_sprites = load(sprites_path + IDLE_ANIM_NAME + SPRITE_FILE_EXT)
	running_anim_sprites = load(sprites_path + RUNNING_ANIM_NAME + SPRITE_FILE_EXT)


func play_idle() -> void:
	%Sprite2D.texture = idle_anim_sprites
	%AnimationPlayer.play(IDLE_ANIM_NAME)


func play_running(moving_right: bool) -> void:
	%Sprite2D.flip_h = !moving_right
	%Sprite2D.texture = running_anim_sprites
	%AnimationPlayer.play(RUNNING_ANIM_NAME)
