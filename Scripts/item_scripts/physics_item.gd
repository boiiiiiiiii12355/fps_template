extends RigidBody3D
class_name physics_item


var speed: float = 3
@export var equip_timer : Timer
@export var item_name : String = "undefined_physics_item"
@export var pickup_area : Area3D
@onready var root_node = owner

func object_function(check : bool):
	print("no function defined")

func object_reload():
	print("object is not reloadable")
	
func look_follow(state: PhysicsDirectBodyState3D, current_transform: Transform3D, target_position: Vector3) -> void:
	var forward_local_axis: Vector3 = Vector3(0, 0, 1)
	var forward_dir: Vector3 = (current_transform.basis * forward_local_axis).normalized()
	var target_dir: Vector3 = (target_position - current_transform.origin).normalized()
	var local_speed: float = clampf(speed, 0, acos(forward_dir.dot(target_dir)))
	if forward_dir.dot(target_dir):
		state.angular_velocity = local_speed * forward_dir.cross(target_dir) / state.step
		
		
func _integrate_forces(state):
	if target_point:
		look_follow(state, global_transform, target_point)
		target_point = null
	if req_linear_velocity:
		state.linear_velocity = req_linear_velocity
		req_linear_velocity = null
		
var req_linear_velocity
@export var equip_rotation : Vector3
@export var equip_position : Vector3
func item_equip(equip_node, arms_anim : AnimationTree):
	reparent(equip_node)
	self.remove_from_group("pickable")
	self.remove_from_group("interactable")
	linear_velocity = Vector3.ZERO
	angular_velocity = Vector3.ZERO
	position = equip_position
	rotation_degrees = equip_rotation
	freeze = true
	if equip_animation_played == false:
		equip_timer.start()
		play_equip_animation()
		equip_animation_played = true
		

#this function also runs when item is not equiped. should change name soon
var owner_animation_ctrl
func picked_up(slot, slot_node, arms_anim : AnimationTree):
	self.remove_from_group("pickable")
	self.remove_from_group("interactable")
	if equip_animation_played == true:
		equip_timer.start()
		play_store_animation()
		equip_animation_played = false
		
	elif equip_animation_played == false:
		freeze = true
		equip_timer.start()
		pickup_area.monitorable = false
		req_linear_velocity = Vector3.ZERO
		angular_velocity = Vector3.ZERO
		position = Vector3.ZERO
		rotation = Vector3.ZERO
		reparent(slot_node)
	
var animation_finished : bool = true
var equip_animation_played : bool = false
func play_equip_animation():
	#define your own depending on item
	pass

func play_store_animation():
	#define your own depending on item
	pass

func play_fire_animation():
	#define your own depending on item
	pass

func play_reload_animation():
	#define your own depending on item
	pass
	
func item_point(look_at):
	#just incase a item needs to point
	
	pass
func dropped():
	self.add_to_group("pickable")
	self.add_to_group("interactable")
	print("dropped")
	freeze = false
	reparent(root_node.objects)
	pickup_area.monitorable = true
	

		
var target_point = Vector3.ZERO
func set_target_rotation(point : Vector3):
	target_point = point
	
