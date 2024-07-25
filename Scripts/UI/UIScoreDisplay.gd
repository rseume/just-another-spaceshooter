extends Label

@export
var _score_counter: ScoreCounter

@onready
var _tween: Tween

var _displayed_score: int = 0


func _ready() -> void:
	_score_counter.connect("score_changed", _on_score_changed)


func _on_score_changed(value: int) -> void:
	if _tween != null && _tween.is_valid():
		_tween.kill()
	_tween = create_tween()
	_tween.tween_method(_update_text, _displayed_score, value, 0.5).set_trans(Tween.TRANS_EXPO)


func _update_text(value: int) -> void:
	_displayed_score = value
	text = Utility.add_digit_before_number(value)
