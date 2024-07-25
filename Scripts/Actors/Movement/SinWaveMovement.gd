extends Node

@export
var _speed: float = 1.0

@export
var _frequency: float = 1.0

@export
var _amplitude: float = 1.0

var _time_passed: float = PI / 2


func _physics_process(delta: float) -> void:
	var value: float = sin(_time_passed * _frequency) * _amplitude
	_time_passed += delta
	var movement: = Vector2(_speed, value)
	movement = movement.rotated(owner.rotation)
	owner.translate(movement * delta)
