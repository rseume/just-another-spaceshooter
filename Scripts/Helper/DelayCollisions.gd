extends Timer

@export_node_path("CollisionObject2D")
var _object: NodePath

@export_flags_2d_physics
var _desired_mask: int = 1


func _on_timeout() -> void:
	queue_free()
