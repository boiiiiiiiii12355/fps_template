extends CharacterBody3D


@export var check_player_sightline : RayCast3D
var player_spotted : bool = false
var player_spot

func _physics_process(delta: float) -> void:
	scan_for_player()
	
func scan_for_player():
	if check_player_sightline.is_colliding():
		if check_player_sightline.get_collider().is_in_group("player_hitbox"):
			player_spot = check_player_sightline.get_collider()
			player_spotted = true

#should finish all this once i figure out navigation meshes
func chase_player():
	pass
