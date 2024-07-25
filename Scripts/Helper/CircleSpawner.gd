extends Node2D

@export
var _min_distance: float = 1.0

@export
var _max_distance: float = 1.0

@export
var _min_amount: int = 1

@export
var _max_amount: int = 10

@export_range(0.0, 1.0)
var _circle_percent: float = 1.0

@export
var _items_to_spawn: Array[SpawningItem]


func spawn() -> void:
	var amount: int = randi_range(_min_amount, _max_amount)

	var inc: float = TAU * _circle_percent / amount
	var offset: float = randf_range(-TAU, TAU)
	var rot: float = inc + offset

	for i in amount:
		var dist: float = randf_range(_min_distance, _max_distance)
		var dir: = Vector2.RIGHT.rotated(rot)
		var item: SpawningItem = Utility.pick_random(_items_to_spawn)
		var instance: Node2D = item.item.instantiate()
		var pos: Vector2 = global_position + dir * dist
		GlobalEvents.instantiate.emit(instance, pos, rot)
		rot += inc
