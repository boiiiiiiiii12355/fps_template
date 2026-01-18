extends Control

var player_inventory : Array
	
@export var slot_1 : RichTextLabel
@export var slot_2 : RichTextLabel
@export var slot_3 : RichTextLabel
@export var selector : ColorRect
@export var player_camera : Camera3D
var ui_hp : float
var req_selector_position : Vector2 = Vector2.ZERO

@export var hp_bar : ProgressBar

func _physics_process(delta: float) -> void:
	selector.global_position = lerp(selector.global_position, req_selector_position, 0.3)
	hp_bar.value = lerp(hp_bar.value, ui_hp, 0.1)
	
func update_inventory_display():
	player_inventory = get_parent().inventory.inventory_array
	if player_inventory[0]:
		slot_1.text = "1 :" + player_inventory[0].item_name
	else:
		slot_1.text = "1 :empty"
	if player_inventory[1]:
		slot_2.text = "2 :" + player_inventory[1].item_name
	else:
		slot_2.text = "2 :empty"
	if player_inventory[2]:
		slot_3.text = "3 :" + player_inventory[2].item_name
	else:
		slot_3.text = "3 :empty"
		
		
func update_inventory_select(slot : int):
	if slot == 1:
		req_selector_position = slot_1.global_position
	elif slot == 2:
		req_selector_position = slot_2.global_position
	elif slot == 3:
		req_selector_position = slot_3.global_position
	
func update_hp_bar(hp, update_type : int):
	ui_hp = hp
	
	if update_type == 1 : #damaged
		pass
		
	elif update_type == 2 : #healed
		pass
		
