extends Node

@onready
var _score_label: Label = $MarginContainer/VBoxContainer/Score


func _ready() -> void:
	GlobalEvents.new_highscore.connect(_on_new_highscore)
	_score_label.text = Utility.add_digit_before_number(Globals.highscore)


func _on_new_highscore(score: int) -> void:
	_score_label.text = Utility.add_digit_before_number(score)
