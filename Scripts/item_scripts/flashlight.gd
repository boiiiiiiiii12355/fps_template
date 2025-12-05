extends physics_item

@export var light : SpotLight3D
func object_function():
	if light.visible == false:
		light.visible = true
	elif light.visible == true:
		light.visible = false
