extends Node

signal pause

const PAUSE_ACTION: String = "Pause"


func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed(PAUSE_ACTION):
		pause.emit()
