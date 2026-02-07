extends BTAction

var last_pos : Vector3
func _tick(delta: float) -> Status:
	var target_pos : Vector3 = blackboard.get_var("move_to_pos")
	var current_pos : Vector3 = agent.global_transform.origin
	
	if agent.check_action_queued():
		return RUNNING
		
	if !agent.check_action_queued():
		agent.add_action(target_pos)
		last_pos = target_pos
		print("target_added")
	
	return SUCCESS
