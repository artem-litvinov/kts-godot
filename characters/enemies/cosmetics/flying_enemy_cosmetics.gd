extends CharacterCosmetics

signal death_finished

const IDLE_ANIM_NAME = "idle"
const HURT_ANIM_NAME = "hurt"
const DEAD_ANIM_NAME = "smoke"
const BLOCKING_ANIMATIONS: Array[String] = [
	HURT_ANIM_NAME,
	DEAD_ANIM_NAME,
]

const SPRITE_FILE_EXT = ".png"
const AVAILABE_SPRITE_IDS: Array[String] = ["flying_monster_3"]

var idle_anim_sprite: Texture
var hurt_anim_sprite: Texture
var dead_anim_sprite: Texture


func _ready() -> void:
	var sprites_path = SpriteManager.get_sprite_path(AVAILABE_SPRITE_IDS.pick_random())
	idle_anim_sprite = load(sprites_path + IDLE_ANIM_NAME + SPRITE_FILE_EXT)
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

	if moving_right:
		%Sprite2D.flip_h = false
		%Sprite2D.position.x = -50
	else:
		%Sprite2D.flip_h = true
		%Sprite2D.position.x = +50
	%Sprite2D.texture = idle_anim_sprite
	%AnimationPlayer.play(IDLE_ANIM_NAME)


func play_hurt() -> void:
	if %AnimationPlayer.current_animation == DEAD_ANIM_NAME:
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
