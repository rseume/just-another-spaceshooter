extends Area2D

@export
var _exclude: Array[CollisionObject2D]

var _obstacles: Array[Node2D]
var _evasive_direction: = Vector2.ZERO

var evasive_direction: Vector2:
	get: return _evasive_direction


var push_vector: Vector2:
	get:
		return _evasive_direction * 1000.0


func _process(_delta: float) -> void:
	_evasive_direction = Vector2.ZERO

	if _obstacles.is_empty():
		return

	for item in _obstacles:
		_evasive_direction += global_position - item.global_position
	_evasive_direction = _evasive_direction.normalized()


func _on_area_entered(area: Area2D) -> void:
	if _exclude.has(area) or _obstacles.has(area):
		return
	_obstacles.append(area)


func _on_area_exited(area: Area2D) -> void:
	_obstacles.erase(area)


func _on_body_entered(body: Node2D) -> void:
	if _exclude.has(body) or _obstacles.has(body):
		return
	_obstacles.append(body)


func _on_body_exited(body: Node2D) -> void:
	_obstacles.erase(body)
