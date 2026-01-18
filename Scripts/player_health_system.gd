extends Node

@export var player_hitbox : Area3D
@export var environment_damage_timer : Timer
@export var maximum_hp = 100
var hp = maximum_hp

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	owner.hud.update_hp_bar(hp, 2)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	check_env()

func check_env():
	if player_hitbox.get_overlapping_areas() and environment_damage_timer.is_stopped():
		for i in player_hitbox.get_overlapping_areas():
			if i.is_in_group("env_player_hurt"):
				owner.hud.update_hp_bar(hp, 1)
				environment_damage_timer.start()
				hp -= 25
