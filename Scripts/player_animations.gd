extends Node3D

@export var skeleton : Skeleton3D
@export var camera_point : Node3D
@export var animation_tree : AnimationTree
var chest_bone_idx

func _ready() -> void:
	for i in skeleton.get_bone_count():
		if skeleton.get_bone_name(i):
			chest_bone_idx = i
			
var chest_angle : float = 0
func chest_point_at(r_position):
	camera_point.global_position = r_position
	chest_angle = skeleton.get_bone_pose_rotation(chest_bone_idx).normalized().get_euler(2).y
	print(chest_angle)
	
var local_vel_mag : float = 0
func walk_anim_update(velocity_magnitude : float, speed : float):
	local_vel_mag = lerp(local_vel_mag, velocity_magnitude, 0.2)
	animation_tree.set("parameters/walk/blend_position", local_vel_mag)
