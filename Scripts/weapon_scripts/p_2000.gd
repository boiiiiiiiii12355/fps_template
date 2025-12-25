extends physics_item

@export var weapon_model : Node3D
var animation_player : AnimationPlayer

func _ready() -> void:
	animation_player = weapon_model.get_child(2)
	
func play_equip_animation():
	animation_player.play("p2000_equip")
	get_tree().call_group("player_animations", "play_equip_animation", "p2000_equip")
	
func object_function():
	animation_player.seek(0)
	animation_player.play("fire")
