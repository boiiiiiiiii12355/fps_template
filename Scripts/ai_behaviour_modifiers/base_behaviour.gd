extends Node
class_name base_behaviour

@onready var body : CharacterBody3D = owner
@onready var speed = body.speed
@onready var wishvelocity : Vector3 = Vector3.ZERO
@onready var nav_agent : NavigationAgent3D = body.nav_agent
@onready var player_dist : float 
@onready var player_chase_dist : float = 5
@onready var player : Player = body.player
@onready var check_player_sightline : RayCast3D = body.check_player_sightline
@onready var interaction_area : Area3D = body.interaction_area
@onready var specified_target : Node3D = body.specified_target
@onready var action_cooldown : Timer = body.action_cooldown
@onready var area_scanner : Node3D = body.area_scanner
@onready var model : Node3D = body.model
var emotion_state : int = 1 # 1 : calm, 2 : panic, 3 : trauma, 4 : virtuous
var action_state : int = 1 # 1 : neutral, 2 : chasing player, 3 : opening door
var rand_num = RandomNumberGenerator.new()
var player_spotted : bool = false
var thoughts : String #mostly for debugging
var action_queue : Array
var target_pos
var main_target_pos


#this is a sort of baseline for all future AIs. its not too passive nor aggresive. a grunt basically

#__stuff to implement__
#   approach player when player is out of sight
#   moves to nearby cover if exposed and player is in sight
#   patrol patterns
#   follows commands from a (commander) like "hang back", "full push" or "retreat"
