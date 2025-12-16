extends Node3D

@export var camera_point : Node3D
@export var animation_tree : AnimationTree

func chest_point_at(r_position):
	camera_point.global_position = r_position
	
var local_vel_mag : float = 0
func walk_anim_update(velocity_magnitude : float, speed : float):
	local_vel_mag = lerp(local_vel_mag, velocity_magnitude, 0.2)
	animation_tree.set("parameters/walk/blend_position", local_vel_mag)
