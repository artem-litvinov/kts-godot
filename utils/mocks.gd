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
		"villager_1",
		100,
		200,
		200
	),
	Hero.from_params(
		"2",
		"Alice",
		Enums.Gender.FEMALE,
		Enums.HeroType.ASSASIN,
		Enums.HeroTier.A,
		"Alice description",
		"villager_2",
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
		"villager_3",
		100,
		200,
		200
	),
]
