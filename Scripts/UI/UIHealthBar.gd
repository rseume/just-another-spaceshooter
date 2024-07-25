extends ProgressBar

@export
var _color_gradient: Gradient

var _fill: StyleBoxFlat = get("theme_override_styles/fill")
var _tween: Tween


func _setup_bar() -> void:
	var value_percentage : float = value / max_value
	_fill.bg_color = _color_gradient.sample(value_percentage)


func _update_value(value_: int) -> void:
	value = value_
	_setup_bar()


func on_value_changed(value_: int) -> void:
	if _tween != null && _tween.is_valid():
		_tween.kill()
	_tween = create_tween()
	_tween.tween_method(_update_value, value, value_, 0.5).set_trans(Tween.TRANS_EXPO)


func _on_health_changed(health: int, _max_health: int) -> void:
	if not visible:
		show()
	on_value_changed(health)


func _on_player_health_changed(health: int, _max_health: int) -> void:
	on_value_changed(health)


func _on_health_health_setup(health: int, max_health: int) -> void:
	max_value = max_health
	_update_value(health)
