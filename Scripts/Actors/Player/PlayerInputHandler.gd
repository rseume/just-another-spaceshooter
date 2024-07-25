extends Node

signal kill_self

const LEFT: String = "Left"
const RIGHT: String = "Right"
const UP: String = "Up"
const DOWN: String = "Down"
const FIRE_1: String = "Fire 1"
const FIRE_2: String = "Fire 2"
const DESTROY_SELF: String = "Destroy Self"

var _movement_input: = Vector2.ZERO
var _fire_1: bool = false
var _fire_2: bool = false


var movement_input: Vector2:
	get:
		return _movement_input

var fire_1: bool:
	get: return _fire_1

var fire_2: bool:
	get: return _fire_2


func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed(DESTROY_SELF):
		kill_self.emit()


func _process(_delta: float) -> void:
	_movement_input = Input.get_vector(LEFT, RIGHT, UP, DOWN)
	_fire_1 = Input.is_action_pressed(FIRE_1)
	_fire_2 = Input.is_action_just_pressed(FIRE_2)
