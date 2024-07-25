extends RefCounted
class_name ItemCollectedData

var item: InventoryItem
var collector: Node2D


func _init(item_: InventoryItem, collector_: Node2D) -> void:
	item = item_
	collector = collector_
