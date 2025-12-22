extends Node3D
class_name player_animations

@export var skeleton : Skeleton3D
@export var camera_point : Node3D
@export var legs_point : Node3D
@export var animation_tree : AnimationTree
@export var chest_tracker : Node3D
@export var head_tracker : BoneAttachment3D
@export var camera_spine : Node3D
var chest_angle : float = 0

func chest_point_at(r_position):
	camera_point.global_position = r_position
	camera_spine.global_position = head_tracker.global_position
	turn_body_to_cam()
	
func turn_body_to_cam():
	legs_point.global_position.x = lerp(legs_point.global_position.x, camera_point.global_position.x, 0.1)
	legs_point.global_position.z = lerp(legs_point.global_position.z, camera_point.global_position.z, 0.1)
	self.look_at(legs_point.global_position)

func crouch_enter():
	animation_tree.set("parameters/movement/crouch_enter_oneshot/request", "fire")
	animation_tree.set("parameters/movement/run_to_crouch/blend_amount", 1)
	
func crouch_exit():
	animation_tree.set("parameters/movement/run_to_crouch/blend_amount", 0)
	
var local_vel_mag : Vector2 = Vector2.ZERO
func walk_anim_update(velocity_magnitude : Vector2):
	local_vel_mag = lerp(local_vel_mag, velocity_magnitude, 0.2)
	animation_tree.set("parameters/movement/run/blend_position", local_vel_mag)
