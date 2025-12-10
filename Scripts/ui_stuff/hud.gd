extends Control

var player_inventory : Array
	
@export var slot_1 : RichTextLabel
@export var slot_2 : RichTextLabel
@export var slot_3 : RichTextLabel
@export var selector : ColorRect
var req_selector_position : Vector2 = Vector2.ZERO


func _physics_process(delta: float) -> void:
	selector.global_position = lerp(selector.global_position, req_selector_position, 0.3)
	
func update_inventory_display():
	player_inventory = get_parent().inventory.inventory_array
	slot_1.text = "1 :" + str(player_inventory[0])
	slot_2.text = "2 :" + str(player_inventory[1])
	slot_3.text = "3 :" + str(player_inventory[2])

func update_inventory_select(slot : int):
	if slot == 1:
		req_selector_position = slot_1.global_position
	elif slot == 2:
		req_selector_position = slot_2.global_position
	elif slot == 3:
		req_selector_position = slot_3.global_position
	
