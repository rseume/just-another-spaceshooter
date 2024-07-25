extends Control

@onready
var _score_label: Label = $VBoxContainer/Label2

var _tween: Tween


func _ready() -> void:
	GlobalEvents.new_highscore.connect(_on_new_highscore)


func _on_new_highscore(score: int) -> void:
	_score_label.text = str(score)
	show()

	if _tween != null && _tween.is_valid():
		_tween.kill()

	_tween = create_tween()

	_tween.tween_property(
		self, "scale", Vector2.ONE * 2.0, 1.0
	).from(Vector2.ZERO).set_trans(Tween.TRANS_SINE)

	_tween.tween_property(
		self, "modulate", Color.TRANSPARENT, 1.0
	).from(Color.WHITE).set_trans(Tween.TRANS_SINE)

	_tween.tween_callback(hide)
