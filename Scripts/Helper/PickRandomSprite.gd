extends Sprite2D

@export
var _sprites: Array[Texture2D]


func _ready() -> void:
	texture = _sprites.pick_random()
