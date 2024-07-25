extends Area2D
class_name Hurtbox

signal impact(data: HitboxImpactData)

@onready
var _reactions: Array[Node] = $Reactions.get_children()


func hit(data: HitboxImpactData) -> void:
	for reaction in _reactions:
		reaction.action(data)
	impact.emit(data)
