extends Node3D
class_name playermodel

@export var skeleton : Skeleton3D
@export var arms_model : Node3D
@export var camera_point : Node3D
@export var legs_point : Node3D
@export var animation_tree : AnimationTree
@export var chest_tracker : Node3D
@export var head_tracker : BoneAttachment3D
@export var camera_spine : Node3D
var equip_node : Node3D
var chest_angle : float = 0.0
var rtc_blend_amount = 0.0
var arms_action
var stand_to_crouch = "parameters/stand_to_crouch/blend_amount"
var arms_action_blend = "parameters/arms_action_blend/blend_amount"
#these are variables for physical slot nodes

@export var slot1 : Node3D
@export var slot2 : Node3D
@export var slot3 : Node3D

func _ready() -> void:
	equip_node = arms_model.get_child(0).get_child(0).get_child(0).get_child(0)
	arms_action = animation_tree.tree_root.get_node("arms_action")
	print(arms_action)
	play_arm_animation("self_inspect_rig")
	
func _physics_process(delta: float) -> void:
	equip_node.get_parent().scale = Vector3(1, 1, 1)
	animation_tree.set(stand_to_crouch, lerp(animation_tree.get(stand_to_crouch), rtc_blend_amount, 0.05))
	
func chest_point_at(r_position):
	camera_point.global_position = r_position
	camera_spine.global_position = head_tracker.global_position
	turn_body_to_cam()
	

func turn_body_to_cam():
	var dist = (camera_point.global_position - legs_point.global_position).length()
	var dir = camera_point.global_position - legs_point.global_position
	if dist >= 3:
		legs_point.global_position += dir.normalized() * 0.1
	if get_parent().velocity:
		legs_point.global_position = lerp(legs_point.global_position, camera_point.global_position, 0.1)
	
func crouch_enter():
	rtc_blend_amount = 1.0
	self.position.y = .4
	
func crouch_exit():
	rtc_blend_amount = 0.0
	self.position.y = 0
 
	
var local_vel_mag : Vector2 = Vector2.ZERO
func walk_anim_update(velocity_magnitude : Vector2):
	local_vel_mag = lerp(local_vel_mag, velocity_magnitude, 0.2)
	animation_tree.set("parameters/idle_to_walk/blend_position", local_vel_mag)
	animation_tree.set("parameters/crouch_to_crouchwalk/blend_position", local_vel_mag)

func play_arm_animation(name : String):
	arms_action.animation = name
	print("played")

func play_arm_animation_from_start(name : String):
	print("played")
	arms_action.animation = name
