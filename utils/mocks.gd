extends Node

var mock_user: User = User.from_params("12345abcde", "Bob")
var mock_world_state: WorldState = WorldState.from_params(20, 50, 100, false)
var mock_heroes: Array[Hero] = [
	Hero.from_params(
		"1",
		"Ben",
		Enums.Gender.MALE,
		Enums.HeroType.FIGHTER,
		Enums.HeroTier.S,
		"Ben description",
		"medieval_knight",
		"https://firebasestorage.googleapis.com/v0/b/kts-backend.appspot.com/o/testImages%2FstyledAvatars_medieval_knight.png?alt=media",
		100,
		200,
		200
	),
	Hero.from_params(
		"2",
		"Alice",
		Enums.Gender.FEMALE,
		Enums.HeroType.ASSASSIN,
		Enums.HeroTier.A,
		"Alice description",
		"elf_archer_2",
		"https://firebasestorage.googleapis.com/v0/b/kts-backend.appspot.com/o/testImages%2FstyledAvatars_elf_archer_2.png?alt=media",
		100,
		200,
		200
	),
	Hero.from_params(
		"3",
		"Bob",
		Enums.Gender.MALE,
		Enums.HeroType.MAGE,
		Enums.HeroTier.B,
		"Bob description",
		"shamans_1",
		"https://firebasestorage.googleapis.com/v0/b/kts-backend.appspot.com/o/testImages%2FstyledAvatars_shamans_1.png?alt=media",
		100,
		200,
		200
	),
]
var mock_event = Events.AIEvent.from_params(
	"As the hero trudges through the dense underbrush of the wilds, a glistening, semi-transparent slime catches their eye, undulating gently among the fallen leaves. The creature's vibrant green hue stands out against the earthy tones of the forest floor, its gelatinous form pulsing with an almost hypnotic rhythm. The hero pauses, sensing both the curiosity and the potential danger that this peculiar encounter presents.",
	Events.EventEnemy.from_params("Slime", 60, 120),
	[
		Events.Option.from_params("Attack the slime!", Events.OptionResults.from_params("You killed the slime", -20, 20, 10, 10)),
		Events.Option.from_params("Lick the slime (•؎ •)", Events.OptionResults.from_params("You licked the slime", -40, 0, -20, 0)),
		Events.Option.from_params("Run away!", Events.OptionResults.from_params("Your ran off", 0, 0, -10, 0)),
	]
)
