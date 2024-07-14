extends CharacterCosmetics

const IDLE_ANIM_NAME = "idle"
const RUNNING_ANIM_NAME = "running"
const HURT_ANIM_NAME = "hurt"
const SPRITE_FILE_EXT = ".png"

var sprites_path: String
var idle_anim_sprite: Texture
var running_anim_sprite: Texture
var hurt_anim_sprite: Texture


func initialize(sprite_id: String) -> void:
	sprites_path = SpriteManager.get_sprite_path(sprite_id)
	idle_anim_sprite = load(sprites_path + IDLE_ANIM_NAME + SPRITE_FILE_EXT)
	running_anim_sprite = load(sprites_path + RUNNING_ANIM_NAME + SPRITE_FILE_EXT)
	hurt_anim_sprite = load(sprites_path + HURT_ANIM_NAME + SPRITE_FILE_EXT)


func play_idle() -> void:
	%Sprite2D.texture = idle_anim_sprite
	%AnimationPlayer.play(IDLE_ANIM_NAME)


func play_running(moving_right: bool) -> void:
	%Sprite2D.flip_h = !moving_right
	%Sprite2D.texture = running_anim_sprite
	%AnimationPlayer.play(RUNNING_ANIM_NAME)


func play_hurt() -> void:
	%Sprite2D.texture = hurt_anim_sprite
	%AnimationPlayer.play(HURT_ANIM_NAME)
