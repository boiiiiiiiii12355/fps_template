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

func _physics_process(delta: float) -> void:
	camera_effect()
	
@export var main_menu_scene : Node3D
func camera_effect():
	var mouse_2d_pos = maps_button_container.get_global_mouse_position() - maps_button_container.get_viewport_rect().get_center()
	var scene_camera : Camera3D = main_menu_scene.camera
	var scene_cam_default_pos = main_menu_scene.cam_default_pos
	scene_camera.global_position.x = lerp(scene_camera.global_position.x, scene_cam_default_pos.x + mouse_2d_pos.x / 4000, 0.1)
	scene_camera.global_position.y = lerp(scene_camera.global_position.y, scene_cam_default_pos.y - mouse_2d_pos.y / 4000, 0.1)
	scene_camera.global_position.y = clamp(scene_camera.global_position.y, scene_cam_default_pos.y, 1000)
	
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
		tmp_map_store.text = (loaded_maps[i].resource_path).replace(map_file_paths, "").replace(".tscn", "").replace("sp_", "").replace("_level", "")
		map_buttons[i] = tmp_map_store
		
func _on_sp_button_pressed() -> void:
	animation_player.play("sp_map_list_show")


func _on_back_pressed() -> void:
	animation_player.play_backwards("sp_map_list_show")
