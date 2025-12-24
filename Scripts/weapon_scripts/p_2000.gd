extends physics_item

@export var weapon_model : Node3D
var animation_player : AnimationPlayer

func _ready() -> void:
	animation_player = weapon_model.get_child(2)
	
func object_function():
	animation_player.seek(0)
	animation_player.play("test_anim")
