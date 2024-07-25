extends Node


func _ready() -> void:
	randomize()
	get_tree().change_scene_to_packed.call_deferred(Globals.GAME_SCENE)
