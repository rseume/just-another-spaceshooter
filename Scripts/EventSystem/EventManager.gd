extends Node

var _events: = Dictionary()


func add_listener(event: RefCounted, action: Callable) -> bool:
	var listeners: Array = _events.get(event, [])
	if listeners.has(action):
		return false
	listeners.append(action)
	_events[event] = listeners
	return true


func remove_listener(event: RefCounted, action: Callable) -> bool:
	var listeners = _events.get(event, null)
	if not listeners:
		return false
	if not listeners.has(action):
		return false
	listeners.erase(action)
	return true


func broadcast(type: RefCounted, event: RefCounted) -> bool:
	var listeners = _events.get(type, null)
	if listeners == null:
		return false
	for action in listeners:
		action.call(event)
	return true
