extends Node
class_name AIStateMachine

var _current_state: AIState


func setup(state: AIState) -> void:
	_current_state = state
	_current_state.on_enable()


func _process(delta: float) -> void:
	_check_transitions()
	_current_state.tick(delta)


func _physics_process(delta: float) -> void:
	_current_state.fixed_tick(delta)


func _check_transitions() -> void:
	var new_state: AIState = _current_state.get_transition()
	if _current_state != new_state:
		change_state(new_state)


func change_state(new_state: AIState) -> void:
	_current_state.on_disable()
	_current_state = new_state
	_current_state.on_enable()
