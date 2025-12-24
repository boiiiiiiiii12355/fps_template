extends Node

var inventory_owner = null
var owner_model : Node3D
var inventory_array : Array
var slot_phys_array : Array
var equipted_slot : int
@export var hud : Control
@export var max_slots : int = 3
@export var item_belt : Node3D
@export var equip_pos : Node3D
var slot1_phys : Node3D
var slot2_phys : Node3D
var slot3_phys : Node3D


			
func _ready() -> void:
	inventory_owner = self.get_parent()
	inventory_array.resize(max_slots)
	owner_model = self.get_parent().get_child(0)
	slot1_phys = owner_model.slot1
	slot2_phys = owner_model.slot2
	slot3_phys = owner_model.slot3
	slot_phy_init()
	
func _physics_process(delta: float) -> void:
	for i in inventory_array.size():
		if inventory_array[i] != null and (i + 1) != inventory_owner.selected_inventory_slot:
			inventory_array[i].picked_up(i, slot_phys_array[i])
		elif inventory_array[i] != null and (i + 1) == inventory_owner.selected_inventory_slot:
			inventory_array[i].item_equip(equip_pos)
			inventory_array[i].set_target_rotation(inventory_owner.pickup_point.global_position)
			
			
func pickup(object : Object, slot : int):
	if inventory_array[slot] == null:
		inventory_array[slot] = object
		hud.update_inventory_display()
		
var throw_speed = 10
func drop(slot : int):
	if inventory_array[slot - 1] != null:
		var throw_velocity = (inventory_owner.pickup_point.global_position - inventory_owner.pickup_hold_area.global_position) * throw_speed
		inventory_array[slot - 1].global_position = inventory_owner.view.global_position
		inventory_array[slot - 1].req_linear_velocity =  throw_velocity
		inventory_array[slot - 1].pickup_area.monitorable = true
		inventory_array[slot - 1].dropped()
		inventory_array[slot - 1] = null
		hud.update_inventory_display()

func slot_phy_init():
	slot_phys_array.resize(3)
	slot_phys_array[0] = slot1_phys
	slot_phys_array[1] = slot2_phys
	slot_phys_array[2] = slot3_phys
