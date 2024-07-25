extends CharacterBody2D

@export
var _max_speed: float = 1.0

@export
var _slide_speed: float = 1.0

@export
var _acceleration: float = 1.0

@export
var _friction: float = 1.0

@export
var _turn_speed: float = 1.0

@export
var _score_counter: ScoreCounter

@export
var _inventory: Inventory

@onready
var _inputs: Node = $InputHandler

@onready
var _gun: Node2D = $Guns

@onready
var _health: Health = $Health

var _slide_direction: = Vector2.ZERO


var score_counter: ScoreCounter:
	get: return _score_counter

var inventory: Inventory:
	get: return _inventory

var health: Health:
	get: return _health


func _ready() -> void:
	_score_counter.restart()


func _process(delta: float) -> void:
	_handle_velocity(delta)
	_handle_shooting()


func _physics_process(delta: float) -> void:
	_handle_turning(delta)
	_handle_movement()


func _handle_velocity(delta: float) -> void:
	var movement_input: Vector2 = _inputs.movement_input
	if movement_input != Vector2.ZERO:
		velocity = velocity.move_toward(
			movement_input * _max_speed,
			_acceleration * delta
		)
		_slide_direction = velocity.normalized()
	else:
		velocity = velocity.move_toward(_slide_direction * _slide_speed, _friction * delta)


func _handle_shooting() -> void:
	if _inputs.fire_1:
		_gun.shoot()


func _handle_turning(delta: float) -> void:
	var look_angle: float = (get_global_mouse_position() - position).angle()
	rotation = lerp_angle(rotation, look_angle, _turn_speed * delta)


func _handle_movement() -> void:
	move_and_slide()
