extends physics_item
@export var weapon_model : Node3D
@export var muzzle_flash : OmniLight3D
@export var gun_ray : RayCast3D
var animation_player : AnimationPlayer

func _ready() -> void:
	animation_player = weapon_model.get_child(2)
	
func play_equip_animation():
	animation_player.play("p2000_equip")
	get_tree().call_group("player_animations", "play_arm_animation", "p2000_equip")
	
func  play_store_animation():
	get_tree().call_group("player_animations", "play_arm_animation", "p2000_store")
	
func object_function():
	if equip_timer.is_stopped():
		animation_player.seek(0)
		get_tree().call_group("player_animations", "play_arm_animation_from_start", "p2000_fire")
		animation_player.play("fire")
		check_hit()
		muzzle_flash.omni_range = 1000
		await get_tree().create_timer(0.1).timeout
		muzzle_flash.omni_range = 0

@onready var root_node : Level = owner
var hit_particle = preload("res://particle_effects/hit_particles.tscn")
func check_hit():
	if gun_ray.get_collider():
		var hit_particle_clone = hit_particle.instantiate()
		root_node.particles.add_child(hit_particle_clone)
		DrawLine3d.DrawLine(gun_ray.global_position, gun_ray.get_collision_point(), Color.YELLOW, 0.01)
		hit_particle_clone.global_position = gun_ray.get_collision_point()
		hit_particle_clone.rotation = gun_ray.get_collision_normal()
		hit_particle_clone.restart()
		
	else:
		return false
