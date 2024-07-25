extends Node

@export_node_path("Node")
var _health_: NodePath

@onready
var _health: Health = get_node(_health_)


func action(data: HitboxImpactData) -> void:
	_health.damage(data.damage)
