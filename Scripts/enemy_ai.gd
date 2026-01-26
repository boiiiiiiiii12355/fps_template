extends CharacterBody3D


@export var check_player_sightline : RayCast3D
@export var navigation_agent : NavigationAgent3D
@export var max_hp = 100
var hp = max_hp
var player_spotted : bool = false
var player_spot
var player : Player
var wishvelocity : Vector3 = Vector3.ZERO

func _ready() -> void:
	player = owner.player
	
func _physics_process(delta: float) -> void:
	velocity = lerp(velocity, wishvelocity, 0.1)
	gravity()
	scan_for_player()
	if player_spotted:
		chase_player()
		move_and_slide()
		
func scan_for_player():
	check_player_sightline.look_at(player.global_position, Vector3(0,0,1), true)
	if check_player_sightline.is_colliding():
		if check_player_sightline.get_collider().is_in_group("player_hitbox"):
			player_spot = check_player_sightline.get_collider()
			player_spotted = true

func gravity():
	if !is_on_floor():
		wishvelocity.y += -0.2
	else:
		wishvelocity.y = 0
	
#should finish all this once i figure out navigation meshes
var speed = 3
var player_chase_dist = 5 #meter
#this controls how far away the ai should stop when chasing the player
func chase_player():
	look_at(player.global_position)
	var player_dir = (player.global_position - global_position).normalized()
	var player_dist = (player.global_position - global_position).length()
	if player_dist > player_chase_dist:
		wishvelocity.x = player_dir.x * speed
		wishvelocity.z = player_dir.z * speed
	else: 
		wishvelocity.x = 0
		wishvelocity.z = 0
	
