extends Node2D

@export
var _object_to_spawn: PackedScene


func action(_data) -> void:
	spawn()


func spawn() -> void:
	var obj: Node2D = _object_to_spawn.instantiate()
	GlobalEvents.instantiate.emit(obj, global_position, global_rotation)
