extends Node2D


func rotate_towards_direction(direction: Vector2) -> void:
	global_rotation = direction.angle()
