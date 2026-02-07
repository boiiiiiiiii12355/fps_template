extends BTAction

func _tick(delta: float) -> Status:
	#logic
	var pos = Vector3(
		randf_range(-20.0, 20.0), #x
		0,                      #y
		randf_range(-20.0, 20.0)  #z
		)
	blackboard.set_var("move_to_pos", pos)
	return SUCCESS
