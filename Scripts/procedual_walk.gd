extends Node3D

var leftfoot  : Object
var rightfoot : Object
var raycastfootL : RayCast3D
var raycastfootR : RayCast3D
var raycastbody : RayCast3D
var body : Object
var movement_body : CharacterBody3D

var req_pos_L = Vector3.ZERO
var req_pos_R = Vector3.ZERO
var step_time = 0

func _ready() -> void:
	leftfoot = $leftfoot
	rightfoot = $rightfoot
	raycastfootL = $body/raycast_foot_L
	raycastfootR = $body/raycast_foot_R
	raycastbody = $body/raycast_body
	body = $body
	movement_body = self.get_parent()
	
func _physics_process(delta: float) -> void:
	raycast_foot_move_combo()
	if req_pos_L and req_pos_R:
		leftfoot.global_position = lerp(leftfoot.global_position, req_pos_L, 0.5)
		rightfoot.global_position = lerp(rightfoot.global_position, req_pos_R, 0.5)
	
func raycast_foot_move_combo():
	print(check_dist(rightfoot, leftfoot))
	if Input.is_action_pressed("move_left"):
		if check_dist(rightfoot, raycastbody) > 2 :
			req_pos_R = foot_to_raycast(raycastbody)
		if check_dist(leftfoot, body) > 2 :
			req_pos_L = foot_to_raycast(raycastfootL)
			
	if Input.is_action_pressed("move_right"):
		if check_dist(rightfoot, body) > 2 :
			req_pos_R = foot_to_raycast(raycastfootR)
		if check_dist(leftfoot, raycastbody) > 2 :
			req_pos_L = foot_to_raycast(raycastbody)
			
func check_dist(object, to):
	var vec3_diff = (object.global_position - to.global_position).length()
	return vec3_diff
	print(vec3_diff)
	
func foot_to_raycast(to : RayCast3D):
	if to.is_colliding():
		return to.get_collision_point()
	
func check_floor(raycast : RayCast3D):
	if raycast.is_colliding():
		return raycast.get_collision_point()
	else:
		return Vector3.ZERO
	
