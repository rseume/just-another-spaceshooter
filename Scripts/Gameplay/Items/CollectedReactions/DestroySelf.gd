extends Node


func action(_data: ItemCollectedData) -> void:
	owner.queue_free()
