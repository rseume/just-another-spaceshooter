extends AIState
class_name SeekState

const MIN_DISTANCE: float = 10.0
const MIN_DIST_SQRD: float = MIN_DISTANCE * MIN_DISTANCE

var _turn_speed: float = 2.0

var _controller: CharacterBody2D
var _seek_position: Vector2


func _init(controller: CharacterBody2D) -> void:
	_controller = controller


func on_enable() -> void:
	_controller.set_target_lost(false)
	_seek_position = _controller.last_target_position


func tick(_delta: float) -> void:
	var target_dir: Vector2 = _seek_position - _controller.position
	var dist: float = target_dir.length_squared()
	target_dir = target_dir.normalized()

	_controller.set_target_direction(target_dir)

	if dist <= MIN_DIST_SQRD:
		_controller.set_target_lost(true)


func fixed_tick(delta: float) -> void:
	if _controller.velocity != Vector2.ZERO:
		_controller.rotation = lerp_angle(_controller.rotation, _controller.facing_direction, _turn_speed * delta)


func on_disable() -> void:
	pass
