extends Node

var inventory_owner = null
var inventory_array : Array
var slot_phys_array : Array
@export var hud : Control
@export var max_slots : int = 3
@export var item_belt : Node3D
@export var slot1_phys : Node3D
@export var slot2_phys : Node3D
@export var slot3_phys : Node3D


			
func _ready() -> void:
	inventory_owner = self.get_parent()
	inventory_array.resize(max_slots)
	slot_phy_init()
	
func _physics_process(delta: float) -> void:
	item_belt.global_rotation.y = inventory_owner.camera_spine.global_rotation.y
	for i in inventory_array.size():
		if not inventory_array[i] == null:
			inventory_array[i].picked_up(i, slot_phys_array[i])
			
func pickup(object : Object, slot : int):
	if inventory_array[slot] == null:
		inventory_array[slot] = object
		hud.update_inventory_display()
		
var throw_speed = 10
func drop(slot : int):
	print(get_tree())
	var throw_velocity = (inventory_owner.pickup_point.global_position - inventory_owner.pickup_hold_area.global_position) * throw_speed
	inventory_array[slot - 1].global_position = inventory_owner.pickup_hold_area.global_position
	inventory_array[slot - 1].linear_velocity =  throw_velocity
	inventory_array[slot - 1].set_target_rotation(inventory_owner.pickup_point.global_position)
	inventory_array[slot - 1] = null
	hud.update_inventory_display()

func slot_phy_init():
	slot_phys_array.resize(3)
	slot_phys_array[0] = slot1_phys
	slot_phys_array[1] = slot2_phys
	slot_phys_array[2] = slot3_phys
