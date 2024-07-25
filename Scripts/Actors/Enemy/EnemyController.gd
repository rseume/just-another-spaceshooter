extends CharacterBody2D

@export
var _max_speed: float = 1.0

@export
var _acceleration: float = 1.0

@export
var _friction: float = 1.0

@onready
var _state_machine: AIStateMachine = $StateMachine

@onready
var _gun: Node2D = $Guns

@onready
var _soft_collision: Area2D = $SoftCollision

var _target: Node2D
var _target_lost: bool

var _target_direction: Vector2
var _last_target_position: Vector2

var _velocity: = Vector2.ZERO
var _knockback_vector: = Vector2.ZERO


var last_target_position: Vector2:
	get: return _last_target_position

var target: Node2D:
	get: return _target

var facing_direction: float:
	get: return _velocity.angle()


func set_target_direction(value: Vector2) -> void:
	_target_direction = value


func set_target_lost(value: bool) -> void:
	_target_lost = value


func _ready() -> void:
	_setup_ai()


var seek: SeekState

func seek_target(target_pos: Vector2) -> void:
	if _target != null:
		return
	_last_target_position = target_pos
	_state_machine.change_state(seek)


func knockback(force: Vector2) -> void:
	_knockback_vector += force


func _setup_ai() -> void:
	var aggro: = AggroState.new(self, _gun)
	seek = SeekState.new(self)
	var wander: = WanderState.new(self, transform.x)

	var has_target: Callable = func () -> bool:
		return _target != null

	var no_target: Callable = func () -> bool:
		return _target == null

	wander.add_transition(aggro, has_target)
	aggro.add_transition(seek, no_target)
	seek.add_transition(wander, func(): return _target_lost)
	seek.add_transition(aggro, has_target)

	_state_machine.setup(wander)


func _process(delta: float) -> void:
	if _target_direction != Vector2.ZERO:
		var desired_velocity: Vector2 = _target_direction * _max_speed
		var steering: Vector2 = desired_velocity - velocity
		desired_velocity += steering
		desired_velocity += _soft_collision.push_vector
		_velocity = _velocity.move_toward(desired_velocity, _acceleration * delta)
	else:
#		TODO: Implement some kind of sliding velocity when standing still!
		_velocity = _velocity.move_toward(Vector2.ZERO, _friction * delta)

	velocity = _velocity + _knockback_vector
	_knockback_vector = _knockback_vector.move_toward(Vector2.ZERO, _friction * delta)


func _physics_process(_delta: float) -> void:
	move_and_slide()


func _on_target_spotted(value: Node2D, is_visible_: bool) -> void:
	if is_visible_:
		_target = value
	else:
		if _target == value:
			_last_target_position = _target.position
			_target = null
