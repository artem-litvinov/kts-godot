extends Node

var mock_user: User = User.from_params("12345abcde", "Bob")
var mock_world_state: WorldState = WorldState.from_params(100, false)
var mock_heroes: Array[Hero] = [
	Hero.from_params(
		"1",
		"Ben",
		Enums.Gender.MALE,
		Enums.HeroType.FIGHTER,
		Enums.HeroTier.S,
		"Ben description",
		"medieval_knight",
		"https://firebasestorage.googleapis.com/v0/b/kts-backend.appspot.com/o/styledAvatars%2Fmedieval_knight.jpg?alt=media&token=5f4a2c78-ca6e-4ded-a8bf-bba82bfa467f",
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
		"https://firebasestorage.googleapis.com/v0/b/kts-backend.appspot.com/o/styledAvatars%2Felf_archer_2.jpg?alt=media&token=f9557b1f-903e-4834-8652-da14a170826c",
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
		"https://firebasestorage.googleapis.com/v0/b/kts-backend.appspot.com/o/styledAvatars%2Fshamans_1.jpg?alt=media&token=adcc0390-393b-4a5d-a28d-a53767cbc06f",
		100,
		200,
		200
	),
]
var mock_event = Events.AIEvent.from_params(
	"As the hero trudges through the dense underbrush of the wilds, a glistening, semi-transparent slime catches their eye, undulating gently among the fallen leaves. The creature's vibrant green hue stands out against the earthy tones of the forest floor, its gelatinous form pulsing with an almost hypnotic rhythm. The hero pauses, sensing both the curiosity and the potential danger that this peculiar encounter presents.",
	Events.EventEnemy.from_params("Slime", 60, 120),
	[
		Events.Option.from_params("Attack the slime!", Events.OptionResults.from_params("You killed the slime", -20, 20)),
		Events.Option.from_params("Lick the slime (•؎ •)", Events.OptionResults.from_params("You licked the slime", -40, -20)),
		Events.Option.from_params("Run away!", Events.OptionResults.from_params("Your ran off", 0, 0)),
	]
)
