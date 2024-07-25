extends Node2D

@export
var _projectile: PackedScene

@export_flags_2d_physics
var _target_layer: int = 1

@export
var _cooldown_duration: float = 0.5

@export
var _setup_origin: bool = true

@onready
var _spawn_points: Array[Node] = $SpawnPoints.get_children()

@onready
var _cooldown_timer: Timer = $CooldownTimer

var _can_shoot: bool = true


func shoot() -> void:
	if not _can_shoot:
		return

	_can_shoot = false
	_cooldown_timer.start(_cooldown_duration)
	for point in _spawn_points:
		_spawn_projectile(point.global_position, point.global_rotation)


func _spawn_projectile(pos: Vector2, rot: float) -> void:
	var projectile: Node2D = _projectile.instantiate()
	var data: = ProjectileData.new(owner if _setup_origin else null, _target_layer, owner.get("target"))
	projectile.setup(data)
	GlobalEvents.instantiate.emit(projectile, pos, rot)


func _on_cooldown_timer_timeout() -> void:
	_can_shoot = true
