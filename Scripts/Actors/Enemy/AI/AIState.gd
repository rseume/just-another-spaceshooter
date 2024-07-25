extends RefCounted
class_name AIState

var _transitions: Array[AITransition]


func on_enable() -> void:
	pass


func tick(_delta: float) -> void:
	pass
	#print_debug("This func should be overwritten")


func fixed_tick(_delta: float) -> void:
	pass


func on_disable() -> void:
	pass


func add_transition(state: AIState, condition: Callable) -> void:
	var transition: = AITransition.new(state, condition)
	_transitions.append(transition)


func try_add_transition(transition: AITransition) -> bool:
	return try_add(transition, _transitions)


func try_add(obj, list: Array) -> bool:
	if obj in list:
		return false
	list.append(obj)
	return true


func get_transition() -> AIState:
	for t in _transitions:
		if t.decide():
			return t.get_state()
	return self
