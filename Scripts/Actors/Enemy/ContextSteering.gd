extends Node2D

@export
var _look_ahead: float = 100.0

@export
var _num_rays: int = 8

@export_range(0.0, 1.0)
var _percent: float = 1.0

@export_range(-180.0, 180.0)
var _offset: float = 0.0

@export_flags_2d_physics
var _collision_mask: int = 1

@export
var _collide_with_areas: bool = false

@export
var _collide_with_bodies: bool = true

var _rays: Array[RayCast2D]
#var _debug_ray: RayCast2D


func _ready() -> void:
	_rays.resize(_num_rays)

	var angle: float = deg_to_rad(_offset)
	var inc: float = TAU * _percent / _num_rays
	var target_pos: = Vector2.RIGHT * _look_ahead

	for i in _num_rays:
		var ray: = RayCast2D.new()
		ray.target_position = target_pos
		ray.rotation = angle
		ray.collision_mask = _collision_mask
		ray.collide_with_areas = _collide_with_areas
		ray.collide_with_bodies = _collide_with_bodies
		add_child.call_deferred(ray)
		_rays[i] = ray
		angle += inc

	#_debug_ray = RayCast2D.new()
	#_debug_ray.modulate = Color.YELLOW
	#_debug_ray.collision_mask = _collision_mask
	#_debug_ray.collide_with_areas = _collide_with_areas
	#_debug_ray.collide_with_bodies = _collide_with_bodies
	#add_child.call_deferred(_debug_ray)


func _physics_process(_delta: float) -> void:
	pass
	#_debug_ray.target_position = steer_direction(Vector2.RIGHT) * 300.0


func steer_direction(direction: Vector2) -> Vector2:
	var results: Array[float] = []
	results.resize(_num_rays)
	_set_interest(direction, results)
	_set_danger(results)
	return _choose_direction(direction, results)


func _set_interest(direction: Vector2, results: Array[float]) -> void:
	for i in _num_rays:
		var dot: float = direction.dot(_rays[i].transform.x)
		results[i] = max(0.0, dot)


func _set_danger(results: Array[float]) -> void:
	for i in _num_rays:
		if _rays[i].is_colliding():
			results[i] = 0.0


func _choose_direction(_direction: Vector2, results: Array[float]) -> Vector2:
	var chosen_dir: = Vector2.ZERO
	var best_dot: float = 0.0
	for i in _num_rays:
		if results[i] > best_dot:
			best_dot = results[i]
			chosen_dir = _rays[i].transform.x
	return chosen_dir
