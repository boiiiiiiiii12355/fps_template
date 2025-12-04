extends PlayerInputs
class_name Player

@onready var bonker = $Headbonk
@export var mySkin : MeshInstance3D
@export var myShape : CollisionShape3D
@export var spring : SpringArm3D
@export var camera_dist = 0
@export var camera_spine : Node3D
@onready var coyoteTimer = $CoyoteTime
var default_camera_pos
var randm = RandomNumberGenerator.new()
var height = 2 #the model is 2 meter tall


func _ready():
	mySkin.set_sorting_offset(1)
	#get_viewport().get_camera_3d()
	default_camera_pos = view.transform.origin
	camera = get_node(stats.camPath)
	print(stats.vel)
	spring.spring_length = 0
	spring.margin = 8
	stats.on_floor = false
	spring.add_excluded_object(self.get_rid())
	
func _process(delta):
	camera_dist = clamp(4+(sqrt(stats.vel.length())/1.5),8, 100)
	view.fov = clamp(70+sqrt(stats.vel.length()*7),90, 180)
	
		
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		InputKeys()
		
		ViewAngles(delta)
	
	stats.snap = -get_floor_normal()

	stats.wasOnFloor = stats.on_floor

	
	velocity = stats.vel
	stored_velocity()
	move_and_slide_own()
	stats.vel = velocity
	
	if stats.wasOnFloor && !stats.on_floor:
		print("start timer")
		coyoteTimer.start()
	
	if stats.on_floor and stats.shouldJump == false:
		fall_impact()
		
	if(stats.on_floor):
		stats.shouldJump = true
	else:
		if coyoteTimer.is_stopped():
			stats.shouldJump = false
			#print("timer stopped")
			pass
	
	if pickup_target:
		pickup(pickup_target)
		
	#bunch of camera effects when moving
	var req_view_transform = default_camera_pos + fall_cam_bob 
	view.transform.origin = lerp(view.transform.origin, req_view_transform + (camera_bob(step_time) * 3), change_magnitude)
	view.rotation.z = lerp(view.rotation.z, movement_tilt(), 0.07)
		
	if velocity.length():
		step_time += (delta * stats.vel.length() * float(stats.on_floor))
	else:
		step_time = 0
		
	var step_boundary = camera_bob(0).y + default_camera_pos.y
	if view.transform.origin.y < step_boundary and step_sound_trigg == false:
		step_sounds()
		step_sound_trigg = true
		
	elif view.transform.origin.y > step_boundary:
		step_sound_trigg = false
		

		

var step_sound_trigg = false
@export var player_sound : Node
func step_sounds():
	player_sound.play_sound("Concrete" + str(randm.randi_range(1, 4)), global_position)

var change_magnitude = 0.1
var fall_displacement = .02
var fall_cam_bob = Vector3.ZERO
func fall_impact():
	player_sound.play_sound("Concrete4", global_position)
	fall_cam_bob.y = (-fall_displacement * abs(stored_vel.y))
	print(velocity.length())
	change_magnitude = 1
	await get_tree().create_timer(0.001).timeout
	change_magnitude = 0.1
	fall_cam_bob.y = 0
	
var stored_vel = Vector3.ZERO
func stored_velocity():
	if velocity:
		stored_vel = velocity

var step_time = 0.0
var headbob_frequency = 2.5
var headbob_amplitude = 0.04
func camera_bob(headbob_time):
	var headbob_position = Vector3.ZERO
	headbob_position.y = sin(headbob_time * headbob_frequency) * headbob_amplitude
	headbob_position.x = cos(headbob_time * headbob_frequency / 2) * headbob_amplitude
	return headbob_position
	
@export var cam_tilt_init = 10.0
@export var tilt_magnitude = 0.1
func movement_tilt():
	if stats.sidemove:
		var tilt_ratio = stats.sidemove / 4096.0
		var tilt_equation = tilt_ratio * tilt_magnitude
		if stats.sidemove > cam_tilt_init or stats.sidemove < -cam_tilt_init:
			return tilt_equation
		else:
			return 0.0
	else:
		return 0.0
		
func clearCoyote():
	coyoteTimer.stop()
	stats.shouldJump = false
	stats.on_floor = false

func CheckVelocity():
	# bound velocity
	# Bound it.
	if stats.vel.length() > stats.ply_maxvelocity:
		stats.vel = stats.vel.normalized() * stats.ply_maxvelocity

	elif stats.vel.length() < -stats.ply_maxvelocity:
		stats.vel = stats.vel.normalized() * stats.ply_maxvelocity




## Perform a move-and-slide along the set velocity vector. If the body collides
## with another, it will slide along the other body rather than stop immediately.
## The method returns whether or not it collided with anything.
func move_and_slide_own() -> bool:
	var collided := false

	# Reset previously detected floor
	stats.on_floor  = false


	#check floor
	var checkMotion := velocity * (1/60.)
	checkMotion.y  -= stats.ply_gravity * (1/360.)
		
	var testcol := move_and_collide(checkMotion, true)

	if testcol:
		var testNormal = testcol.get_normal()
		if testNormal.angle_to(up_direction) < stats.ply_maxslopeangle:
			stats.on_floor = true

	# Loop performing the move
	var motion := velocity * get_delta_time()
	

	for step in max_slides:
		
		
		var collision := move_and_collide(motion)
		
		if not collision:
			# No collision, so move has finished
		
			break

		# Calculate velocity to slide along the surface
	
		var normal = collision.get_normal()
		
		motion = collision.get_remainder().slide(normal)
		velocity = velocity.slide(normal)


		# Collision has occurred
		collided = true


	return collided
	
func get_delta_time() -> float:
	if Engine.is_in_physics_frame():
		return get_physics_process_delta_time()

	return get_process_delta_time()

func pickup(object : RigidBody3D):
	var pickup_velocity = (pickup_hold_area.global_position - object.global_position) * pickup_speed
	object.angular_velocity = (object.angular_velocity - view.rotation)
	object.linear_velocity = pickup_velocity
	
