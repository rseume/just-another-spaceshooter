extends Node

@export
var _area: Rect2

@onready
var _timer: Timer = $Timer

@export
var _min_waittime: float

@export
var _max_waittime: float

@export
var _items: Array[SpawningItem]


func _ready() -> void:
	set_active(true)


func set_active(active: bool) -> void:
	if active:
		_start_timer()
	else:
		_timer.stop()


func _start_timer() -> void:
	var waittime: float = randf_range(_min_waittime, _max_waittime)
	_timer.start(waittime)


func _spawn_item() -> void:
	var item: SpawningItem = Utility.pick_random(_items)
	var instance: Node2D = item.item.instantiate()
	var position: = Vector2(
		randf_range(_area.position.x, _area.end.x),
		randf_range(_area.position.y, _area.end.y),
	)
	GlobalEvents.instantiate.emit(instance, position)


func _on_timer_timeout() -> void:
	_spawn_item()
	_start_timer()
