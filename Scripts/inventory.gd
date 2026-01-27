extends Node

var inventory_owner = null
var owner_model : Node3D
var inventory_array : Array
var slot_phys_array : Array
var equipted_slot : int
var equip_node : Node3D
var arms_animationplayer : AnimationTree
@export var hud : Control
@export var max_slots : int = 3
@export var item_belt : Node3D
@export var equip_pos : Node3D
@export var player_animation : Node3D
@export var gun_point : RayCast3D
var slot1_phys : Node3D
var slot2_phys : Node3D
var slot3_phys : Node3D


			
func _ready() -> void:
	inventory_owner = self.get_parent()
	inventory_array.resize(max_slots)
	owner_model = self.get_parent().get_child(0)
	arms_animationplayer = player_animation.animation_tree
	arms_animationplayer.animation_finished.connect(arms_free)
	arms_animationplayer.animation_started.connect(arms_buzy)
	equip_node = owner_model.equip_node
	slot1_phys = owner_model.slot1
	slot2_phys = owner_model.slot2
	slot3_phys = owner_model.slot3
	slot_phy_init()
	
func _physics_process(delta: float) -> void:
	if arms_buzy_stat:
		inventory_process()
		
	
var inventory_processed : bool = false
var last_selected_slot = 0
func inventory_process():
	for i in inventory_array.size():
		var selected_slot = inventory_owner.selected_inventory_slot - 1
		#bit of a clunky system but this allows animation skipping on equip straight to storing animation
		#it works by checking if your last selected slot is the same as the current selected slot
		#if its not it will run the picked_up() function of that item
		if last_selected_slot != selected_slot and inventory_array[last_selected_slot] and inventory_array[selected_slot]:
			inventory_array[last_selected_slot].picked_up(i, slot_phys_array[i], arms_animationplayer)
			last_selected_slot = selected_slot
			await  arms_animationplayer.animation_finished
			
			
		if inventory_array[i] != null and (i) != selected_slot:
			inventory_array[i].picked_up(i, slot_phys_array[i], arms_animationplayer)
		elif inventory_array[selected_slot] and arms_animationplayer:
			inventory_array[selected_slot].item_equip(equip_node, arms_animationplayer)
			inventory_array[selected_slot].item_point(player_animation.gun_point.global_position)
			
		
		if i == inventory_array.size():
			last_selected_slot = selected_slot
		
	
	
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

var arms_buzy_stat : bool = true
func arms_free(anim_name : String):
	if anim_name.contains("store"):
		print("set")
		arms_buzy_stat = true

func arms_buzy(anim_name : String):
	if anim_name.contains("store"):
		print("not")
		arms_buzy_stat = false
