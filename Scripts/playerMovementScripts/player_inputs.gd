extends CharacterBody3D
class_name PlayerInputs
#CODE THAT PARSES USER INPUT
#just organized like this for organization's sake
@export var stats : Resource
@export var view : Camera3D
@export var inventory : Node
@export var interact_ray : RayCast3D
@export var pickup_hold_area : Node3D
@export var pickup_speed = 20
var flashlight_toggle = false
var camera : Node3D


func _ready():
	push_warning("You should not be seeing this (player_inputs.gd is being initiated)")
	
func _input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		InputMouse(event)
		
	if event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
	if event.is_action_pressed("click"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			
	if event.is_action_pressed("restart"):
		stats.vel = Vector3(0,0,0)
		get_tree().reload_current_scene()

func InputMouse(event):
	stats.xlook += -event.relative.y * stats.ply_xlookspeed 
	stats.ylook += -event.relative.x * stats.ply_ylookspeed
	
	
	stats.xlook = clamp(stats.xlook, stats.ply_maxlookangle_down, stats.ply_maxlookangle_up)
	
func interact_check():
	if interact_ray.is_colliding():
		var object = interact_ray.get_collider().get_parent()
		return object
	else:
		return null
		
func ViewAngles(delta):
	camera.rotation_degrees.x = stats.xlook
	camera.rotation_degrees.y = stats.ylook
	
func InputKeys():
	stats.sidemove += int(stats.ply_sidespeed) * (int(Input.get_action_strength("move_left") * 50))
	stats.sidemove -= int(stats.ply_sidespeed) * (int(Input.get_action_strength("move_right") * 50))
	
	stats.forwardmove += int(stats.ply_forwardspeed) * (int(Input.get_action_strength("move_forward") * 50))
	stats.forwardmove -= int(stats.ply_backspeed) * (int(Input.get_action_strength("move_back") * 50))
	
	# Clamp that shit so it doesn't go too high
	if Input.is_action_just_released("move_left") or Input.is_action_just_released("move_right"):
		stats.sidemove = 0
	else:
		stats.sidemove = clamp(stats.sidemove, -4096, 4096)
		
	if Input.is_action_just_released("move_forward") or Input.is_action_just_released("move_back"):
		stats.upmove = 0
	else:
		stats.upmove = clamp(stats.upmove, -4096, 4096)
	if Input.is_action_just_released("move_forward") or Input.is_action_just_released("move_back"):
		stats.forwardmove = 0
	else:
		stats.forwardmove = clamp(stats.forwardmove, -4096, 4096)
	
	#auxilary actions
	if Input.is_action_just_pressed("click"):
		pass
	
	if Input.is_action_just_pressed("interact") and interact_check():
		interact_check().object_function()
	elif Input.is_action_just_pressed("interact"):
		print("nothing here...")
		
	if Input.is_action_pressed("pickup") and interact_check():
		pickup_target = interact_check()
	elif !Input.is_action_just_pressed("pickup"):
		pickup_target = null
		
var pickup_target 
func pickup(object):
	pass
