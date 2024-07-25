extends RefCounted
class_name ProjectileData

var origin: Node
var target_layer: int
var target: Node2D


func _init(origin_: Node, target_layer_: int, target_: Node2D) -> void:
	origin = origin_
	target_layer = target_layer_
	target = target_
