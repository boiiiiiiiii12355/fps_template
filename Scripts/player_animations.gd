extends Node3D

@export var skeleton : Skeleton3D
@export var camera_point : Node3D
@export var animation_tree : AnimationTree
@export var chest_tracker : BoneAttachment3D
@export var camera_spine : Node3D
var chest_angle : float = 0
func chest_point_at(r_position):
	camera_point.global_position = r_position
	turn_body_to_cam()
	
func turn_body_to_cam():
	print(chest_tracker.rotation.y)
	if chest_tracker.rotation.y > 0.4:
		self.rotation.y += 0.01
	elif chest_tracker.rotation.y < -0.6:
		self.rotation.y -= 0.01

		
var local_vel_mag : Vector2 = Vector2.ZERO
func walk_anim_update(velocity_magnitude : Vector2):
	local_vel_mag = lerp(local_vel_mag, velocity_magnitude, 0.2)
	print(velocity_magnitude)
	animation_tree.set("parameters/walk/blend_position", local_vel_mag)
