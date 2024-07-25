extends Control

@onready
var _label: Label = $Label

var _tween: Tween
var _playing: bool = false
var _count: int


func _ready() -> void:
	show()


func play(count: int = 3) -> void:
	_label.show()

	if _tween != null && _tween.is_valid():
		_tween.kill()
	_playing = true

	while _playing:
		_label.text = str(count)
		_tween = create_tween()
		_start_tween()

		await _tween.finished
		count -= 1
		if count == 0:
			_playing = false

	hide()


func _start_tween() -> void:
	_label.scale = Vector2.ZERO
	_tween.tween_property(
		_label, "scale", Vector2.ONE * 2.0, 0.5
	).set_trans(Tween.TRANS_SINE)

	_label.modulate = Color.WHITE
	_tween.tween_property(
		_label, "modulate", Color.TRANSPARENT, 0.5
	).set_trans(Tween.TRANS_SINE)


func _update_count() -> void:
	_count -= 1
