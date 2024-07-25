extends Node


func _ready() -> void:
	GlobalEvents.instantiate.connect(_on_instantiate)


func _on_instantiate(instance: Node, position: = Vector2.ZERO, rotation: float = 0.0) -> void:
	if instance is Node2D:
		instance.position = position
		instance.rotation = rotation
	add_child.call_deferred(instance)
