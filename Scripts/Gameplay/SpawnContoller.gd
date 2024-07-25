extends Node2D

@onready
var _timer: Timer = $Timer

var _min_waittime: float
var _max_waittime: float
var _items: Array

var _max_active_instances: int = 3
var _current_active_instances: int = 0


func _ready() -> void:
	pass


func setup(items: Array[SpawningItem], spawn_timer: Vector2) -> void:
	_items = items
	_min_waittime = spawn_timer.x
	_max_waittime = spawn_timer.y


func set_active(active: bool) -> void:
	if active:
		_start_timer()
		_spawn_item()
	else:
		_timer.stop()


func _start_timer() -> void:
	var waittime: float = randf_range(_min_waittime, _max_waittime)
	_timer.start(waittime)


func _spawn_item() -> void:
	var item: SpawningItem = Utility.pick_random(_items)
	var instance: Node2D = item.item.instantiate()
	var offset: float = randf_range(-25.0, 25.0)
	offset = deg_to_rad(offset)
	GlobalEvents.instantiate.emit(instance, position, rotation + offset)
	instance.tree_exiting.connect(_on_item_destroyed)
	_current_active_instances += 1
	if _current_active_instances == _max_active_instances:
		_timer.stop()


func _on_timer_timeout() -> void:
	_start_timer()
	_spawn_item()


func _on_item_destroyed() -> void:
	_current_active_instances -= 1
	if _current_active_instances < _max_active_instances && _timer.is_stopped():
		_start_timer()
