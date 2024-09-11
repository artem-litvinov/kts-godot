extends VBoxContainer


func initialize(participant_name: String, attack: int, hp: int):
	%Name.text = participant_name
	%Attack.text = str(attack)
	%HP.text = str(hp)
