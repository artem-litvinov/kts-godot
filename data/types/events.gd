extends Resource

class_name Events


class AIEvent:
	var description: String
	var enemy: EventEnemy
	var options: Array[Option]

	func _to_string():
		return "Event: description - " + description

	static func from_json(json: Dictionary) -> AIEvent:
		var event = AIEvent.new()

		event.description = json["eventSetup"]["eventStory"]

		var enemy_json = json["eventSetup"].get("enemy", null)
		if enemy_json:
			event.enemy = EventEnemy.from_json(enemy_json)

		event.options = [] as Array[Option]
		for option in json["options"]:
			event.options.append(Option.from_json(option))

		return event

	static func from_params(_description: String, _enemy: EventEnemy, _options: Array[Option]) -> AIEvent:
		var event = AIEvent.new()

		event.description = _description
		event.enemy = _enemy
		event.options = _options

		return event


class EventEnemy:
	var name: String
	var attack: int
	var hp: int

	static func from_json(json: Dictionary) -> EventEnemy:
		var enemy = EventEnemy.new()

		enemy.name = json["name"]
		enemy.attack = json["attack"]
		enemy.hp = json["hp"]

		return enemy

	static func from_params(_name: String, _attack: int, _hp: int) -> EventEnemy:
		var enemy = EventEnemy.new()

		enemy.name = _name
		enemy.attack = _attack
		enemy.hp = _hp

		return enemy


class Option:
	var description: String
	var results: OptionResults

	static func from_json(json: Dictionary) -> Option:
		var option = Option.new()

		option.description = json["option"]
		option.results = OptionResults.from_json(json["result"])

		return option

	static func from_params(_description: String, _results: OptionResults) -> Option:
		var option = Option.new()

		option.description = _description
		option.results = _results

		return option


class OptionResults:
	var description: String
	var hp_delta: int
	var supplies_delta: int

	static func from_json(json: Dictionary) -> OptionResults:
		var results = OptionResults.new()

		results.description = json["desc"]
		results.hp_delta = json.get("hpDelta", 0)
		results.supplies_delta = json.get("suppliesDelta", 0)

		return results

	static func from_params(
		_description: String,
		_hp_delta: int,
		_supplies_delta: int,
	) -> OptionResults:
		var results = OptionResults.new()

		results.description = _description
		results.hp_delta = _hp_delta
		results.supplies_delta = _supplies_delta

		return results
