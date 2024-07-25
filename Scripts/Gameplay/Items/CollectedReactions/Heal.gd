extends Node

@export
var _healing: int = 10


func action(data: ItemCollectedData) -> void:
	data.collector.health.heal(_healing)
