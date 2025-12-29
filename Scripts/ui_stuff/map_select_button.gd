extends Button
class_name  map_select_button 

var assigned_map = "no map assigned"
@onready var root_node = owner

func _pressed() -> void:
	print("loading... " + str(assigned_map))
	get_tree().change_scene_to_packed(assigned_map)
	
