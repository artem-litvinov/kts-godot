extends Control


func update_resources(food: int, morale: int, supplies: int):
	%Food.update_value(food)
	%Morale.update_value(morale)
	%Supplies.update_value(supplies)
