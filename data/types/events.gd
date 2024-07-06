extends Resource

class_name Events


class AIEvent:
	var description: String
	var enemy: Enemy
	var options: Array[Option]

	func _to_string():
		return "Event: description - " + description

	static func from_json(json: Dictionary) -> AIEvent:
		var event = AIEvent.new()

		event.description = json["eventSetup"]["eventStory"]
		event.enemy = Enemy.from_json(json["eventSetup"]["enemy"])
		event.options = []
		for option in json["options"]:
			event.options.append(Option.from_json(option))

		return event

	static func from_params(_description: String, _enemy: Enemy, _options: Array[Option]) -> AIEvent:
		var event = AIEvent.new()

		event.description = _description
		event.enemy = _enemy
		event.options = _options

		return event


class Enemy:
	var name: String
	var attack: int
	var hp: int

	static func from_json(json: Dictionary) -> Enemy:
		var enemy = Enemy.new()

		for param in json.keys():
			if param in enemy:
				enemy.set(param, json[param])
			else:
				return null

		return enemy

	static func from_params(_name: String, _attack: int, _hp: int) -> Enemy:
		var enemy = Enemy.new()

		enemy.name = _name
		enemy.attack = _attack
		enemy.hp = _hp

		return enemy


class Option:
	var description: String
	var results: OptionResults

	static func from_json(json: Dictionary) -> Option:
		var option = Option.new()

		option.description = json["optioin"]
		option.results = OptionResults.from_json(json["results"])

		return option

	static func from_params(_description: String, _results: OptionResults) -> Option:
		var option = Option.new()

		option.description = _description
		option.results = _results

		return option


class OptionResults:
	var description: String
	var hpDelta: int
	var foodDelta: int
	var moraleDelta: int
	var suppliesDelta: int

	static func from_json(json: Dictionary) -> OptionResults:
		var results = OptionResults.new()

		results.description = json["desc"]
		results.hpDelta = json["htDelta"]
		results.foodDelta = json["foodDelta"]
		results.moraleDelta = json["moraleDelta"]
		results.suppliesDelta = json["suppliesDelta"]

		return results

	static func from_params(
		_description: String,
		_hpDelta: int,
		_foodDelta: int,
		_moraleDelta: int,
		_suppliesDelta: int,
	) -> OptionResults:
		var results = OptionResults.new()

		results.description = _description
		results.hpDelta = _hpDelta
		results.foodDelta = _foodDelta
		results.moraleDelta = _moraleDelta
		results.suppliesDelta = _suppliesDelta

		return results
