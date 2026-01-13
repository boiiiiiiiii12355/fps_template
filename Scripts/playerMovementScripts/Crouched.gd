extends PlayerState

var player_animation : playermodel
var try_uncrouch = false

func enter(msg := {}) -> void:
	print("crouched")
	player_animation = get_parent().get_parent().player_body
	stats.crouched = true
	stats.speed = stats.ply_crouchspeed 
	if msg.get("try_uncrouch") == true:
		try_uncrouch = true;
	else:
		try_uncrouch = false
	
	
func physics_update(delta: float) -> void:
	if(Input.is_action_just_released("crouch")):
		try_uncrouch = true
		
		
	if(try_uncrouch == true && player.bonker.is_colliding() == false):
		player_animation.crouch_exit()
		state_machine.transition_to("Standing")
		
	if(player.bonker.is_colliding()):
		print("bonking")
