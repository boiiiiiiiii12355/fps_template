extends Node

@export var player_hitbox : Area3D
@export var environment_damage_timer : Timer
@export var maximum_hp = 100
@export var player_model : playermodel
@export var player_ragdoll : ragdoll
var player = owner
var hp = maximum_hp
var dead : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	owner.hud.update_hp_bar(hp, 2)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	check_env()
	if hp < 0:
		spawn_dead_player()
		dead = true
	

func spawn_dead_player():
	var player_skeleton : Skeleton3D = player_model.skeleton
	var ragdoll_skeleton : Skeleton3D = player_ragdoll.skeleton
		
	var cam : Camera3D = owner.player_cam
	player_ragdoll.start_phy()
	owner.dead = true
	cam.position = Vector3.ZERO
	cam.dead = true
	for i in player_skeleton.get_bone_count():
		var pose : = player_skeleton.get_bone_global_pose(i)
		ragdoll_skeleton.set_bone_global_pose(i, pose)
	player_model.player_dead()
	cam.reparent(player_ragdoll.head_tracker)
	
func check_env():
	if player_hitbox.get_overlapping_areas() and environment_damage_timer.is_stopped():
		for i in player_hitbox.get_overlapping_areas():
			if i.is_in_group("env_player_hurt"):
				hp -= 101
				owner.hud.update_hp_bar(hp, 1)
				environment_damage_timer.start()
