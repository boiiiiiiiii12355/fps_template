extends RigidBody3D
class_name physics_item

var speed: float = 0.1

func object_function():
	print("no function defined")

func look_follow(state: PhysicsDirectBodyState3D, current_transform: Transform3D, target_position: Vector3) -> void:
	var forward_local_axis: Vector3 = Vector3(1, 0, 0)
	var forward_dir: Vector3 = (current_transform.basis * forward_local_axis).normalized()
	var target_dir: Vector3 = (target_position - current_transform.origin).normalized()
	var local_speed: float = clampf(speed, 0, acos(forward_dir.dot(target_dir)))
	if forward_dir.dot(target_dir) > 1e-4:
		state.angular_velocity = local_speed * forward_dir.cross(target_dir) / state.step
	
	
func _integrate_forces(state):
	if target_point:
		look_follow(state, global_transform, target_point)
		target_point = null

var target_point = Vector3.ZERO
func set_target_rotation(point : Vector3):
	target_point = point
	
var target_velocity : Vector3
func set_target_velocity(target_velocity : Vector3):
	target_velocity = target_velocity
