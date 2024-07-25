extends RefCounted
class_name PlayerDeathEvent

var player: CharacterBody2D


func _init(player_: CharacterBody2D) -> void:
	player = player_
