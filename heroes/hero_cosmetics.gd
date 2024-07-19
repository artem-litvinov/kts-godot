extends CharacterCosmetics

signal death_finished

const IDLE_ANIM_NAME = "idle"
const RUNNING_ANIM_NAME = "running"
const HURT_ANIM_NAME = "hurt"
const DEAD_ANIM_NAME = "dying"
const BLOCKING_ANIMATIONS: Array[String] = [
	HURT_ANIM_NAME,
	DEAD_ANIM_NAME,
]

const SPRITE_FILE_EXT = ".png"

var idle_anim_sprite: Texture
var running_anim_sprite: Texture
var hurt_anim_sprite: Texture
var dead_anim_sprite: Texture


func initialize(sprite_id: String) -> void:
	var sprites_path = SpriteManager.get_sprite_path(sprite_id)
	idle_anim_sprite = load(sprites_path + IDLE_ANIM_NAME + SPRITE_FILE_EXT)
	running_anim_sprite = load(sprites_path + RUNNING_ANIM_NAME + SPRITE_FILE_EXT)
	hurt_anim_sprite = load(sprites_path + HURT_ANIM_NAME + SPRITE_FILE_EXT)
	dead_anim_sprite = load(sprites_path + DEAD_ANIM_NAME + SPRITE_FILE_EXT)


func play_idle() -> void:
	if %AnimationPlayer.current_animation in BLOCKING_ANIMATIONS:
		return

	%Sprite2D.texture = idle_anim_sprite
	%AnimationPlayer.play(IDLE_ANIM_NAME)


func play_running(moving_right: bool) -> void:
	if %AnimationPlayer.current_animation in BLOCKING_ANIMATIONS:
		return

	%Sprite2D.flip_h = !moving_right
	%Sprite2D.texture = running_anim_sprite
	%AnimationPlayer.play(RUNNING_ANIM_NAME)


func play_hurt() -> void:
	if %AnimationPlayer.current_animation in DEAD_ANIM_NAME:
		return

	if %AnimationPlayer.is_playing():
		%AnimationPlayer.stop()

	%Sprite2D.texture = hurt_anim_sprite
	%AnimationPlayer.play(HURT_ANIM_NAME)

func play_dead() -> void:
	if %AnimationPlayer.current_animation == DEAD_ANIM_NAME:
		return

	if %AnimationPlayer.is_playing():
		%AnimationPlayer.stop()

	%Sprite2D.texture = dead_anim_sprite
	%AnimationPlayer.play(DEAD_ANIM_NAME)


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == DEAD_ANIM_NAME:
		death_finished.emit()
