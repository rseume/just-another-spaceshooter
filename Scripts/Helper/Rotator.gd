extends Node2D

@export
var _random_angle: bool = false

@export
var _min_speed: float = -1.0

@export
var _max_speed: float = 1.0

var _speed: float = randf_range(_min_speed, _max_speed)


func _ready() -> void:
	if _random_angle:
		rotation = randf_range(-TAU, TAU)


func _process(delta: float) -> void:
	rotation += _speed * delta
