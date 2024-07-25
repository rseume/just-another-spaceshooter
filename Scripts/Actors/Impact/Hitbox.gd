extends Area2D
class_name Hitbox

signal impact(data: HitboxImpactData)

@export
var _damage: int = 1

@export
var _exclude_: Array[NodePath]

@onready
var _reactions: Array[Node] = $Reactions.get_children()

var _origin: Node = null
var _exclude: Array[Area2D]


func _ready() -> void:
	for path in _exclude_:
		_exclude.append(get_node(path))


func setup(origin: Node) -> void:
	_origin = origin


func _on_area_entered(area: Area2D) -> void:
	if not area is Hurtbox:
		return
	if area in _exclude:
		return
	var origin: Node = _origin if is_instance_valid(_origin) else null
	var data: = HitboxImpactData.new(origin, area, _damage)
	area.hit(data)
	for reaction in _reactions:
		reaction.action(data)
	impact.emit(data)
