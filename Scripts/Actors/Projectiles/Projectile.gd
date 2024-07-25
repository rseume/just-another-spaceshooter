extends Node2D

var _origin: Node
var _target_layer: int
var _target: Node2D

var origin: Node:
	get: return _origin

var target: Node2D:
	get: return _target


func setup(data: ProjectileData) -> void:
	_origin = data.origin
	_target_layer = data.target_layer
	_target = data.target


func _ready() -> void:
	$Hitbox.setup(_origin)
