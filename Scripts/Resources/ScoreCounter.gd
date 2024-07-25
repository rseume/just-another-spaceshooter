extends Resource
class_name ScoreCounter

signal score_changed

var _score: int = 0


var score: int:
	get: return _score


func add_score(value: int) -> void:
	_score += value
	score_changed.emit(_score)


func restart() -> void:
	_score = 0
	score_changed.emit(_score)
