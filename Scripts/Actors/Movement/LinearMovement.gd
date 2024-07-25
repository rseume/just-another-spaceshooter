extends Node

@export
var _random_speed: bool = false

@export
var _min_speed: float = 1.0

@export
var _max_speed: float = 1.0

@export
var _speed: float = 1.0


func _ready() -> void:
	if _random_speed:
		_speed = randf_range(_min_speed, _max_speed)


func _process(delta: float) -> void:
	owner.translate(owner.transform.x * _speed * delta)
