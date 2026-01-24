extends gun_item_base
class_name  p7_quiver

func play_equip_animation():
	animation_player.play("p7_quiver_equip")
	#get_tree().call_group("player_animations", "play_arm_animation", "p2000_inspect_rig")
	
func  play_store_animation():
	#get_tree().call_group("player_animations", "play_arm_animation", "p2000_store")
	pass
	
func play_reload_animation():
	get_tree().call_group("player_animations", "play_arm_animation", "player_animation/p7_quiver_reload_empt")
	animation_player.play("p7_baked_reload_empt_baked")
	animation_player.seek(0)
	
	
func  play_fire_animation():
	gun_shot_sound.play(0)
	get_tree().call_group("player_animations", "play_arm_animation_from_start", "player_animation/p7_quiver_shoot")
	animation_player.play("p7_quiver_fire_002")
	animation_player.seek(0)
	
func fire_type():
	return "full_auto"
