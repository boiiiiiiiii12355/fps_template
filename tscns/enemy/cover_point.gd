extends Node3D
class_name cover_point


@export var half_body_cover : bool = false
@export var cover_ray : RayCast3D
@export var auto_set : bool = true
func _ready() -> void:
	if auto_set:
		auto_cover_type_set()

func auto_cover_type_set():
	if cover_ray.is_colliding():
		half_body_cover = true
	else:
		half_body_cover = false
	
	
func reserve_cover(reservist : Node3D):
	cover_occupant = reservist
	
func free_up_cover():
	cover_occupant = null
	
	
var cover_occupant : Node3D
func check_cover_availability():
	if cover_occupant:
		return false #not available
		
	else:
		return true #avilable cover

func check_cover_position():
	return global_position
