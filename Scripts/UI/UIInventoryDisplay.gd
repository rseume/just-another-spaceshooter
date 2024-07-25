extends Control

@export
var _inventory: Inventory

@onready
var _slots: Array[Node] = $MarginContainer/VBoxContainer.get_children()


func _ready() -> void:
	_inventory.inventory_changed.connect(_on_inventory_changed)


func _on_inventory_changed(item: InventoryItem, amount: int) -> void:
	for slot in _slots:
		if slot.expected_item == item:
			slot.display(amount)
			break
