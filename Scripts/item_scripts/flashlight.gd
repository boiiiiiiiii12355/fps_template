extends physics_item

func play_equip_animation():
	get_tree().call_group("player_animations", "play_arm_animation", "flashlight_equip")

func  play_store_animation():
	get_tree().call_group("player_animations", "play_arm_animation", "flashlight_store")

@export var light : SpotLight3D
func object_function(check: bool):
	if !check:
		if light.visible == false:
			light.visible = true
		elif light.visible == true:
			light.visible = false
	elif check:
		return fire_type()

func fire_type():
	return "semi_auto"
