extends Node

@export
var _score_to_add: int = 100

@export_node_path("Node")
var _health_: NodePath

@onready
var _health: Health = get_node(_health_)


func action(data: HitboxImpactData) -> void:
	if not data.origin:
		return
	if not data.origin.get("score_counter"):
		return
	if _health.is_dead():
		data.origin.score_counter.add_score(_score_to_add)
