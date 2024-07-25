extends RefCounted
class_name AITransition

var _state: AIState
var _condition: Callable


func _init(state: AIState, condition: Callable) -> void:
	_state = state
	_condition = condition


func decide() -> bool:
	return _condition.call()


func get_state() -> AIState:
	return _state
