extends gun_item_base

func play_equip_animation():
	animation_player.play("p7_quiver_equip")
	get_tree().call_group("player_animations", "play_arm_animation", "p7_quiver equip")
	
func  play_store_animation():
	get_tree().call_group("player_animations", "play_arm_animation", "p2000_store")

func play_reload_animation():
	get_tree().call_group("player_animations", "play_arm_animation", "p7_quiver_reload")
	animation_player.play("p7_quiver_reload")
	animation_player.seek(0)
	
func  play_fire_animation():
	gun_shot_sound.play(0)
	get_tree().call_group("player_animations", "play_arm_animation_from_start", "p7_quiver_fire")
	animation_player.play("p7_quiver_fire")
	animation_player.seek(0)
	
func fire_type():
	return "full_auto"
