extends Node


func notify() -> void:
	GlobalEvents.player_death.emit(owner)
