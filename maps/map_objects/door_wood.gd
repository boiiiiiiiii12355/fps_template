extends physics_item
class_name door_wood

@export var animation_player : AnimationPlayer
@export var door_hitbox : Area3D
@export var open : bool = false
@export var door_open_positions : Node3D
var destroyed : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	freeze = true
	door_anim()
	self.add_to_group("interactable")


func object_function(check : bool):
	if !destroyed:
		if open:
			open = false
		else:
			open = true
		door_anim()
	
func door_anim():
	if open:
		animation_player.play("open")
	else:
		animation_player.play_backwards("open")
		

var door_pos_array : Array 
func find_door_pos(given_position : Vector3, find_furthest : bool):
	door_pos_array.resize(door_open_positions.get_children().size())
	for positions in door_open_positions.get_children():
		door_pos_array[positions.get_index()] = (positions.global_position - given_position).length()
	
	
	if !find_furthest:
		var closest_point_idx = door_pos_array.find(door_pos_array.min())
		return door_open_positions.get_children()[closest_point_idx].global_position
	else:
		var furthest_point_idx = door_pos_array.find(door_pos_array.max())
		return door_open_positions.get_children()[furthest_point_idx].global_position
		
func on_destruct(dir : Vector3):
	freeze = false
	linear_velocity = -dir * 10
	angular_velocity = dir * 5

func _on_door_hitbox_area_entered(area: Area3D) -> void:
	if area.is_in_group("door_destructable"):
		print("door_destroyed")
		destroyed = true
		on_destruct((area.owner.global_position - door_hitbox.global_position).normalized())
		
