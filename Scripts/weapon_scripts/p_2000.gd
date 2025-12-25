extends physics_item
@export var weapon_model : Node3D
@export var muzzle_flash : OmniLight3D
var animation_player : AnimationPlayer

func _ready() -> void:
	animation_player = weapon_model.get_child(2)
	
func play_equip_animation():
	animation_player.play("p2000_equip")
	get_tree().call_group("player_animations", "play_arm_animation", "p2000_equip")
	
func  play_store_animation():
	get_tree().call_group("player_animations", "play_arm_animation", "p2000_store")
	
func object_function():
	if equip_timer.is_stopped():
		animation_player.seek(0)
		get_tree().call_group("player_animations", "play_arm_animation_from_start", "p2000_fire")
		animation_player.play("fire")
		muzzle_flash.omni_range = 100
		await get_tree().create_timer(0.1).timeout
		muzzle_flash.omni_range = 0
