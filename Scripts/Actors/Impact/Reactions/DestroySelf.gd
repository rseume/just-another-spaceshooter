extends Node


func action(_data: HitboxImpactData) -> void:
	owner.queue_free()
