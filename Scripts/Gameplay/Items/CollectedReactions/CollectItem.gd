extends Node


func action(data: ItemCollectedData) -> void:
	if data.collector.inventory.add_item(data.item):
		owner.collected = false
