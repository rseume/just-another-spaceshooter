extends ColorRect

var _tween: Tween


func fade_out() -> void:
	show()
	if _tween != null && _tween.is_valid():
		_tween.kill()
	_tween = create_tween()
	modulate = Color.TRANSPARENT
	_tween.tween_property(self, "modulate", Color.WHITE, 1.0).set_trans(Tween.TRANS_CUBIC)
	await _tween.finished


func fade_in() -> void:
	show()
	if _tween != null && _tween.is_valid():
		_tween.kill()
	_tween = create_tween()
	modulate = Color.WHITE
	_tween.tween_property(self, "modulate", Color.TRANSPARENT, 1.0).set_trans(Tween.TRANS_CUBIC)
	await _tween.finished
	hide()
