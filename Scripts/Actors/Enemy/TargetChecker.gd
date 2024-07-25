extends Area2D

signal target_spotted(value: Node2D, is_visible_: bool)

@onready
var _raycast: RayCast2D = $RayCast2D

var _target: Node2D = null
var _is_target_blocked: bool


func _check_target() -> void:
	_raycast.target_position = to_local(_target.position)

	if not _raycast.is_colliding():
		if _is_target_blocked:
			_is_target_blocked = false
			target_spotted.emit(_target, true)
	else:
		if not _is_target_blocked:
			_is_target_blocked = true
			target_spotted.emit(_target, false)


func _on_body_entered(body: Node2D) -> void:
	target_spotted.emit(body, true)


func _on_body_exited(body: Node2D) -> void:
	target_spotted.emit(body, false)


func _on_timer_timeout() -> void:
	_check_target()
