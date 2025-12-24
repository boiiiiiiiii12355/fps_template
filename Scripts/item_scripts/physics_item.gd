extends RigidBody3D
class_name physics_item

var speed: float = 3
@export var item_name : String = "undefined_physics_item"
@export var pickup_area : Area3D
func object_function():
	print("no function defined")

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
func item_equip(equip_node):
	reparent(equip_node)
	position = Vector3.ZERO
	rotation = Vector3.ZERO
	global_rotation.z = 0
	
func picked_up(slot, slot_node):
	pickup_area.monitorable = false
	req_linear_velocity = Vector3.ZERO
	angular_velocity = Vector3.ZERO
	position = Vector3.ZERO
	rotation = Vector3.ZERO
	reparent(slot_node)
	
func dropped():
	print("dropped")
	reparent(self.get_tree().get_first_node_in_group("physics_objects"))
	pickup_area.monitorable = true
	

		
var target_point = Vector3.ZERO
func set_target_rotation(point : Vector3):
	target_point = point
	
