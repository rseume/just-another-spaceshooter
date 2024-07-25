extends Control

@export
var _expected_item: InventoryItem

@onready
var _label: Label = $Label


var expected_item: InventoryItem:
	get: return _expected_item


func display(amount: int) -> void:
	_label.text = str(amount)
