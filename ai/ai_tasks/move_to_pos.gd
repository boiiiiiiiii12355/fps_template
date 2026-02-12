extends BTAction

var last_pos : Vector3
func _tick(delta: float) -> Status:
	var target_pos : Vector3 
	var current_pos : Vector3 = agent.global_transform.origin
	
	if agent.check_action_queued():
		return RUNNING
		
	if !agent.check_action_queued() and blackboard.get_var("move_to_pos"):
		target_pos = blackboard.get_var("move_to_pos")
		agent.add_action(target_pos)
		last_pos = target_pos
		
	return SUCCESS
