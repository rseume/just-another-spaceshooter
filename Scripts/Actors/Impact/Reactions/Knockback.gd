extends Node

@export
var _knockback_multiplier: float = 20.0

@export
var _use_random: bool = false

@export
var _random_range: Vector2


func action(data: HitboxImpactData) -> void:
	if data.origin == null:
		return
	var dir: Vector2 = data.collider.global_position - data.origin.global_position
	dir = dir.normalized()
	var force: float = _knockback_multiplier
	if _use_random:
		force *= randf_range(_random_range.x, _random_range.y)
	owner.knockback(dir * data.damage * force)
