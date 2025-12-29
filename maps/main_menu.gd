extends Node3D
class_name main_menu

@export var maps_button_offset : Vector2 = Vector2(0, 35)
@export var maps_button_container : ScrollContainer
@export var animation_player : AnimationPlayer
var map_file_paths = "res://maps/playable_maps/"
var loaded_maps : Array
var loaded_map_names : Array
var map_buttons : Array

func _ready() -> void:
	map_list_init()
	
#loads all maps in the playable maps file and makes a button for each of them
func map_list_init():
	var load_num = 0
	loaded_maps.resize(ResourceLoader.list_directory(map_file_paths).size())
	loaded_map_names.resize(ResourceLoader.list_directory(map_file_paths).size())
	map_buttons.resize(ResourceLoader.list_directory(map_file_paths).size())
	for i in ResourceLoader.list_directory(map_file_paths):
		loaded_maps[load_num] = load(map_file_paths + i)
		load_num += 1
	
	for i in loaded_maps.size():
		var tmp_map_store = map_select_button.new()
		maps_button_container.get_child(0).add_child(tmp_map_store)
		tmp_map_store.assigned_map = loaded_maps[i]
		tmp_map_store.position = maps_button_offset * i
		tmp_map_store.text = str("map" + str(i + 1))
		map_buttons[i] = tmp_map_store
		
func _on_sp_button_pressed() -> void:
	animation_player.play("sp_map_list_show")


func _on_back_pressed() -> void:
	animation_player.play_backwards("sp_map_list_show")
