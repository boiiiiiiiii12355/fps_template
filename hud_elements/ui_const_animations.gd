extends Node

@export var item_info_gear1 : Sprite2D
@export var item_info_gear2 : Sprite2D

func _process(delta: float) -> void:
	item_info_gear1.rotation += 0.055
	item_info_gear2.rotation -= 0.05
