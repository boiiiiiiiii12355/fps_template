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
@export var chest_look_at_modi : LookAtModifier3D
@export var upper_chest_look_at_modi : LookAtModifier3D
var chest_angle : float = 0.0
var rtc_blend_amount = 0.0
var kick_blend_amount = 0.0
var arms_action
var stand_to_crouch = "parameters/stand_to_crouch/blend_amount"
var arms_action_blend = "parameters/arms_action_blend/blend_amount"
var arms_action_timeseek = "parameters/arms_action_timeseek/seek_request"
var kick_oneshot = "parameters/kick_oneshot/request"
var kick_timeseek = "parameters/kick_timeseek/seek_request"
var interact_oneshot = "parameters/interact_oneshot/request"

#these are variables for physical slot nodes
@export var equip_node : Node3D
@export var slot1 : Node3D
@export var slot2 : Node3D
@export var slot3 : Node3D

func _ready() -> void:
	arms_action = animation_tree.tree_root.get_node("arms_action")
	
func _physics_process(delta: float) -> void:
	equip_node.get_parent().scale = Vector3(1, 1, 1)
	animation_tree.set(stand_to_crouch, lerp(animation_tree.get(stand_to_crouch), rtc_blend_amount, 0.1))
	animation_tree.set(arms_action_blend, lerp(animation_tree.get(arms_action_blend), float(equip_node.get_children().size()), 0.2))
	
var upperchest_x_offset = 0.62
func chest_point_at(r_position):
	upper_chest_look_at_modi.origin_offset.x = lerp(upper_chest_look_at_modi.origin_offset.x, float(equip_node.get_children().size() * upperchest_x_offset), 0.1)
	camera_point.global_position = lerp(camera_point.global_position, r_position, 0.5)
	camera_spine.global_position = head_tracker.global_position
	turn_body_to_cam()
	

func turn_body_to_cam():
	legs_point.global_position = lerp(legs_point.global_position, camera_point.global_position, 0.05)
	if get_parent().velocity:
		legs_point.global_position = lerp(legs_point.global_position, camera_point.global_position, 0.1)
	
func crouch_enter():
	rtc_blend_amount = 1.0
	self.position.y = .4
	
func crouch_exit():
	rtc_blend_amount = 0.0
	self.position.y = 0
 
func kick_charging():
	pass
	
func kick():
	if !kicking:
		animation_tree.set(kick_oneshot, 1)
		animation_tree.set(kick_timeseek, 0.25)
		check_kick()
	else:
		print("already_kicking")

var kicking : bool = false
func check_kick():
	if animation_tree.get(kick_oneshot) == 1:
		kicking = true
		await animation_tree.animation_finished
		kicking = false

var interact_anim_played : bool = false
func interact_detect():
	if !interact_anim_played:
		animation_tree.set(interact_oneshot, 1)
		interact_anim_played = true
		
func interact_none():
	animation_tree.set(interact_oneshot, 3)
	interact_anim_played = false
	
var local_vel_mag : Vector2 = Vector2.ZERO
func walk_anim_update(velocity_magnitude : Vector2):
	local_vel_mag = lerp(local_vel_mag, velocity_magnitude, 0.2)
	animation_tree.set("parameters/idle_to_walk/blend_position", local_vel_mag)
	animation_tree.set("parameters/crouch_to_crouchwalk/blend_position", local_vel_mag)

func play_arm_animation(name : String):
	arms_action.set_animation(name)
	animation_tree.set(arms_action_timeseek, 0)
	print("played " + str(arms_action.animation))

func play_arm_animation_from_start(name : String):
	arms_action.set_animation(name)
	animation_tree.set(arms_action_timeseek, 0)

@export var kick_hitbox : Area3D
func _on_kick_hitbox_body_entered(body: Node3D) -> void:
	if body.is_in_group("ragdoll"):
		print("hit")
		var bone_parent = body
		var knockback_dir = (bone_parent.global_position - self.global_position).normalized()
		bone_parent.get_parent().get_parent().hit(body, 10000000)
		bone_parent.linear_velocity = knockback_dir * 5
