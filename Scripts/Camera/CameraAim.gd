extends Node2D

@export_node_path("Node2D")
var _target_: NodePath

@export
var _catch_radius: float = 25.0

@export
var _max_distance: float = 100.0

var _target: Node2D


func _ready() -> void:
	set_target(get_node_or_null(_target_))


func set_target(value: Node2D) -> void:
	_target = value
	set_process(_target != null)


func _process(_delta: float) -> void:
	if not is_instance_valid(_target):
		set_target(null)
		return

	var mouse_dir: Vector2 = get_global_mouse_position() - _target.position

	if mouse_dir.length() > _catch_radius:
		position = _target.position + mouse_dir.limit_length(_max_distance)
	else:
		position = _target.position
