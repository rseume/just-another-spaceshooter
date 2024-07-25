extends VisibleOnScreenNotifier2D

@onready
var _timer: Timer = $Timer


func _on_screen_entered() -> void:
	_timer.stop()


func _on_screen_exited() -> void:
	_timer.start()


func _on_timer_timeout() -> void:
	owner.queue_free()
