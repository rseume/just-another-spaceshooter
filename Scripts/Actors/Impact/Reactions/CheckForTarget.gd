extends Node

signal target_spotted(value: Node2D, is_visible_: bool)


func action(data: HitboxImpactData) -> void:
	if data.origin == null || not is_instance_valid(data.origin):
		return
	owner.seek_target(data.origin.global_position)
