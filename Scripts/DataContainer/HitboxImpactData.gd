extends RefCounted
class_name  HitboxImpactData

var origin: Node
var collider: Node
var damage: int


func _init(origin_: Node, collider_: Node, damage_: int = 0) -> void:
	origin = origin_
	collider = collider_
	damage = damage_
