extends Node

var inventory_owner = null
var inventory_array : Array
@export var max_slots : int = 3
func _ready() -> void:
	inventory_owner = self.get_parent()
	inventory_array.resize(max_slots)
	
func pickup(object : Object, slot : int):
	inventory_array[slot] = object

func drop(slot : int):
	inventory_array[slot] = null
