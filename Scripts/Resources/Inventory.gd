extends Resource
class_name Inventory

signal inventory_changed(item, amount)

const MAX_AMOUNT: int = 9

var _inventory: = Dictionary()


func has_item(item: InventoryItem) -> bool:
	return _inventory.has(item)


func has_item_amount(item: InventoryItem, amount: int) -> bool:
	var current: int = _inventory.get(item, 0)
	return current >= amount


func add_item(item: InventoryItem, amount: int = 1) -> bool:
	var current: int = _inventory.get(item, 0)
	if current >= MAX_AMOUNT:
		return false
	current += amount
	current = min(current, MAX_AMOUNT)
	_inventory[item] = current
	inventory_changed.emit(item, current)
	return true


func remove_item(item: InventoryItem, amount: int = 1) -> bool:
	var current: int = _inventory.get(item, 0)
	current -= amount
	if current < 0:
		return false
	_inventory[item] = current
	inventory_changed.emit(item, current)
	return true
