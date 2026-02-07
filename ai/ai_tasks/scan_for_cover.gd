extends BTAction

func _tick(delta: float) -> Status:
	blackboard.set_var("move_to_pos", scan_for_cover())
	return SUCCESS
	
	
var nearby_cover : Array
func scan_for_cover():
	var scanned_count = 0
	nearby_cover.resize(agent.get_tree().get_node_count_in_group("cover_point_collection"))
	for cover : cover_point in agent.get_tree().get_nodes_in_group("cover_point_collection"):
		var availability = cover.check_cover_availability()
		if availability:
			nearby_cover[scanned_count] = cover.check_cover_position()
		
		scanned_count += 1
	print(nearby_cover)
	return nearby_cover[0]
