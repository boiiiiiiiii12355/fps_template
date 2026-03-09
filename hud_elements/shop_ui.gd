extends Control
class_name shop_ui

@export var shop_items_list : Control
@export var shop_state : bool = false
@export var animation_player : AnimationPlayer


func shop_open():
	animation_player.play("shop_toggle")
	for i in shop_items_list.get_children():
		i.queue_free()
	shop_container_populate()

func shop_close():
	animation_player.play_backwards("shop_toggle")
	await animation_player.animation_finished
	for i in shop_items_list.get_children():
		i.queue_free()
		
var shop_item_load = preload("res://hud_elements/shop_item_buttons.tscn")
var test_populate = 7
func shop_container_populate():
	for i in test_populate:
		var shop_item_clone : shop_item_buttons = shop_item_load.instantiate()
		shop_item_clone.rename_button("button" + str(i))
		shop_items_list.add_child(shop_item_clone)
		shop_item_clone.animate_move(Vector2(0, i * 90))
		shop_item_clone.rotation = 180
		print(shop_item_clone.position)
