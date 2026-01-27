extends physics_item
class_name door_wood

@export var animation_player : AnimationPlayer
@export var door_hitbox : Area3D
@export var open : bool = false
var destroyed : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	freeze = true
	door_anim()
	self.add_to_group("interactable")


func object_function(check : bool):
	if !destroyed:
		if open:
			open = false
		else:
			open = true
		door_anim()
	
func door_anim():
	if open:
		animation_player.play("open")
	else:
		animation_player.play_backwards("open")
		

func on_destruct(dir : Vector3):
	freeze = false
	linear_velocity = -dir * 10
	angular_velocity = dir * 5

func _on_door_hitbox_area_entered(area: Area3D) -> void:
	if area.is_in_group("door_destructable"):
		print("door_destroyed")
		destroyed = true
		on_destruct((area.owner.global_position - door_hitbox.global_position).normalized())
		
