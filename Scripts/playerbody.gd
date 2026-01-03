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
@export var equip_node : Node3D
@export var arms_animation_player : AnimationPlayer
var chest_angle : float = 0.0
var rtc_blend_amount = 0.0
var run_to_crouch = "parameters/movement/run_to_crouch/blend_amount"
var crouch_enter_oneshot = "parameters/movement/crouch_enter_oneshot/request"

#these are variables for physical slot nodes

@export var slot1 : Node3D
@export var slot2 : Node3D
@export var slot3 : Node3D

func _ready() -> void:
	arms_animation_player = arms_model.get_child(1)
	equip_node = arms_model.get_child(0).get_child(0).get_child(0).get_child(0)
	arms_animation_player.play("look_at_me_hands")
	
func _physics_process(delta: float) -> void:
	equip_node.get_parent().scale = Vector3(1, 1, 1)
	animation_tree.set(run_to_crouch, lerp(animation_tree.get(run_to_crouch), rtc_blend_amount, 0.1))
	
func chest_point_at(r_position):
	camera_point.global_position = r_position
	camera_spine.global_position = head_tracker.global_position
	turn_body_to_cam()
	
func turn_body_to_cam():
	legs_point.global_position.x = lerp(legs_point.global_position.x, camera_point.global_position.x, 0.1)
	legs_point.global_position.z = lerp(legs_point.global_position.z, camera_point.global_position.z, 0.1)
	self.look_at(legs_point.global_position)

func crouch_enter():
	animation_tree.set(crouch_enter_oneshot, 1)
	rtc_blend_amount = 1.0
	self.position.y = .5
	
func crouch_exit():
	rtc_blend_amount = 0.0
	self.position.y = 0
 
	
var local_vel_mag : Vector2 = Vector2.ZERO
func walk_anim_update(velocity_magnitude : Vector2):
	local_vel_mag = lerp(local_vel_mag, velocity_magnitude, 0.2)
	animation_tree.set("parameters/movement/run/blend_position", local_vel_mag)
	animation_tree.set("parameters/movement/crouch/blend_position", local_vel_mag)

func play_arm_animation(name : String):
	arms_animation_player.play(name)

func play_arm_animation_from_start(name : String):
	arms_animation_player.play(name)
	arms_animation_player.seek(0)
