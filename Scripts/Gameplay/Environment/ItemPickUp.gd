extends Node2D

@export
var _items: Array[InventoryItem]

@onready
var _sprite: Sprite2D = $Sprite2D

@onready
var _reactions: Array[Node] = $Reactions.get_children()

var _item: InventoryItem
var _collected: bool = false


var collected: bool:
	get: return _collected
	set(value): _collected = value


func _ready() -> void:
	setup()


func setup() -> void:
	_item = Utility.pick_random(_items)
	_sprite.texture = _item.icon


func reset() -> void:
	setup()
	_collected = false


func _on_trigger_body_entered(body: Node2D) -> void:
	if _collected:
		return

	var data: = ItemCollectedData.new(_item, body)
	for action in _reactions:
		action.action(data)
