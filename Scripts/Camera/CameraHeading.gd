extends Node2D

@export_node_path("Node2D")
var _target_: NodePath

@export
var _draw_debug: bool = false

@export_color_no_alpha
var _debug_color: = Color.CORNFLOWER_BLUE

@export_range(0.0, 1.0)
var _debug_alpha: float = 1.0

@export
var _debug_size: float = 10.0

@export
var _predicted_time: float = 1.0

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
	position = _target.position + _target.velocity * _predicted_time


func _draw() -> void:
	if _draw_debug:
		_debug_color.a = _debug_alpha
		draw_circle(Vector2.ZERO, _debug_size, _debug_color)
