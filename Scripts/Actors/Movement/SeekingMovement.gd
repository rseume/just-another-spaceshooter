extends Node

signal direction_changed(direction: Vector2)

@export
var _max_speed: float = 1.0

@export
var _starting_speed: float = 1.0

@export
var _acceleration: float = 1.0

@export
var _future_vision: float = 1.0

var _velocity: Vector2


func _ready() -> void:
	_velocity = owner.transform.x * _starting_speed


func _process(delta: float) -> void:
	if is_instance_valid(owner.target):
		var target_pos: Vector2 = owner.target.position
		target_pos += owner.target.velocity * _future_vision
		var desired: Vector2 = owner.position.direction_to(target_pos) * _max_speed
		var steering: Vector2 = desired - _velocity
		_velocity = _velocity.move_toward(_velocity + steering, _acceleration * delta)
		direction_changed.emit(_velocity)
	else:
		_velocity = _velocity.move_toward(owner.transform.x * _max_speed, _acceleration * delta)
	owner.translate(_velocity * delta)
