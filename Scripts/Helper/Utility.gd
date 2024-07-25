extends Node
class_name Utility


static func pick_random(list):
	var count: int = list.size()
	var index: int = randi_range(0, count - 1)
	var item: PropabilityItem = list[index]
	var threshold = randf() - item.propability

	while threshold > 0.0:
		index += 1
		item = list[index % count]
		threshold -= item.propability

	return item


static func add_digit_before_number(number: int, lenght: int = 5, digit: String = "0") -> String:
	var result: String = str(number)
	var diff: int = lenght - result.length()
	for i in diff:
		result = digit + result
	return result
