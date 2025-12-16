extends Node3D

@export var skeleton : Skeleton3D
@export var camera_point : Node3D
@export var animation_tree : AnimationTree
@export var chest_tracker : BoneAttachment3D
			
var chest_angle : float = 0
func chest_point_at(r_position):
	camera_point.global_position = r_position
	print(chest_tracker.global_rotation.y)
	turn_body_to_cam()
	
func turn_body_to_cam():
	if chest_tracker.rotation.y > 0.6:
		self.rotation.y += 0.1
	elif chest_tracker.rotation.y < -0.6:
		self.rotation.y -= 0.1
		
var local_vel_mag : float = 0
func walk_anim_update(velocity_magnitude : float, speed : float):
	local_vel_mag = lerp(local_vel_mag, velocity_magnitude, 0.2)
	animation_tree.set("parameters/walk/blend_position", local_vel_mag)
