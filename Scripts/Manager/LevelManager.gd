extends Node

@export
var _levels: Array[LevelData]

@export
var _score_counter: ScoreCounter

@onready
var _spawners: Array[Node] = get_children()

var _current_level: LevelData
var _current_level_index: int


func _ready() -> void:
	_score_counter.score_changed.connect(_on_score_changed)
	_current_level = _levels[0]
	_setup_level()


func _setup_level() -> void:
	var items: Array[SpawningItem] = _current_level.spawning_items
	var timer: Vector2 = _current_level.spawn_timer

	for spawner in _spawners:
		spawner.set_active(false)

	for path in _current_level.spawn_controller:
		var spawner: Node2D = get_node(path)
		spawner.setup(items, timer)
		spawner.set_active(true)


func _on_score_changed(score: int) -> void:
	if _current_level_index < _levels.size() - 1 && score >= _current_level.next_level_threshold:
		_current_level_index += 1
		_current_level = _levels[_current_level_index]
		_setup_level()
