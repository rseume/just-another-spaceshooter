extends AIState
class_name WanderState

var _controller: CharacterBody2D
var _heading_direction: Vector2

var _turn_speed: float = 1.0


func _init(controller: CharacterBody2D, heading_direction: Vector2) -> void:
	_controller = controller
	_heading_direction = heading_direction


func on_enable() -> void:
	_controller.set_target_direction(_heading_direction)


func tick(_delta: float) -> void:
	pass
	#_controller.set_target_direction(_heading_direction)


func fixed_tick(delta: float) -> void:
	if _controller.velocity != Vector2.ZERO:
		_controller.rotation = lerp_angle(_controller.rotation, _controller.facing_direction, _turn_speed * delta)
