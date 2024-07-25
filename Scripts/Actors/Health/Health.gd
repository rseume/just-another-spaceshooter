extends Node
class_name Health

signal health_setup(health: int, max_health: int)
signal health_changed(health: int, max_health: int)
signal death
signal revived(health: int)
signal invincibility_changed(value: bool)

@export
var _starting_health: int

@export
var _max_health: int

@export
var _make_invincible: bool = false

@export
var _invincibility_duration: float = 0.5

@onready
var _invincibility_timer: Timer = get_node_or_null("InvincibilityTimer")

var _health: int
var _dead: bool = false
var _is_invincible: bool = false


func is_dead() -> bool: return _dead


func _ready() -> void:
	_health = _starting_health
	health_setup.emit(_health, _max_health)


func damage(value: int) -> void:
	if _dead || _is_invincible:
		return
	_health -= value
	_health = max(_health, 0)
	health_changed.emit(_health, _max_health)
	if _health == 0:
		_dead = true
		death.emit()
	elif _make_invincible:
		_is_invincible = true
		_invincibility_timer.start(_invincibility_duration)


func heal(value: int) -> void:
	if _dead:
		return
	_health += value
	_health = min(_health, _max_health)
	health_changed.emit(_health, _max_health)


func kill() -> bool:
	if _dead:
		return false

	_health = 0
	health_changed.emit(_health, _max_health)

	_dead = true
	death.emit()
	return true


func revive(health: int = _starting_health) -> bool:
	if not _dead:
		return false
	_dead = false
	_health = health
	revived.emit(health)
	return true


func _on_invincibility_timer_timeout() -> void:
	_is_invincible = false
