extends AIState
class_name AggroState

const MIN_DISTANCE: float = 100.0
const MIN_DIST_SQRD: float = MIN_DISTANCE * MIN_DISTANCE
const MIN_SHOOTING_ANGLE: float = deg_to_rad(35.0)

var _controller: CharacterBody2D
var _gun: Node2D

var _turn_speed: float = 2.0

var _angle_to_target: float


func _init(controller: CharacterBody2D, gun: Node2D) -> void:
	_controller = controller
	_gun = gun


func on_enable() -> void:
	_controller.set_target_direction(Vector2.ZERO)


func tick(_delta: float) -> void:
	var target_pos: Vector2 = _controller.target.position
	var target_dir: Vector2 = target_pos - _controller.position
	var dist: float = target_dir.length_squared()

	if dist <= MIN_DIST_SQRD:
		_controller.set_target_direction(target_dir)
	else:
		_controller.set_target_direction(Vector2.ZERO)

	_angle_to_target = target_dir.angle()
	var shooting_angle: float = _controller.transform.x.angle_to(target_dir)

	if abs(shooting_angle) <= MIN_SHOOTING_ANGLE:
		_gun.shoot()


func fixed_tick(delta: float) -> void:
	_controller.rotation = lerp_angle(_controller.rotation, _angle_to_target, _turn_speed * delta)


func on_disable() -> void:
	pass
