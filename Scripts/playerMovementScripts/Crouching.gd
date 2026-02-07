extends PlayerState

var player_animation : playermodel
var try_uncrouch = false

func enter(msg := {}) -> void:
	#print("crouching")
	player_animation = get_parent().get_parent().player_body
	stats.crouching = true
	try_uncrouch = false
	stats.speed = stats.ply_crouchspeed 
	
func physics_update(delta: float) -> void:
	player_animation.crouch_enter()
	if(Input.is_action_just_released("crouch")):
		try_uncrouch = true
		
	if(try_uncrouch == true && player.bonker.is_colliding() == false):

		state_machine.transition_to("Standing")
		
		
	player.myShape.scale.y -= 0.1
	player.mySkin.scale.y -= 0.1
	
	player.myShape.scale.y = clamp(player.myShape.scale.y, 0.1, 1)
	player.mySkin.scale.y = clamp(player.mySkin.scale.y, 0.1, 1)
	if(stats.on_floor):
		player.move_and_collide(Vector3(0,-0.1, 0))
	else:
		player.move_and_collide(Vector3(0,0.1, 0))
	
	if(player.myShape.scale.y <=0.5 ):
		state_machine.transition_to("Crouched", {try_uncrouch=try_uncrouch})
