extends Node

@onready
var _minutes_label: Label = $MarginContainer/HBoxContainer/Minutes

@onready
var _seconds_label: Label = $MarginContainer/HBoxContainer/Seconds

var _minutes: int = 0
var _seconds: int = 0


func _on_timer_timeout() -> void:
	_seconds += 1
	if _seconds == 60:
		_seconds = 0
		_minutes += 1
	_minutes_label.text = Utility.add_digit_before_number(_minutes, 2)
	_seconds_label.text = Utility.add_digit_before_number(_seconds, 2)
