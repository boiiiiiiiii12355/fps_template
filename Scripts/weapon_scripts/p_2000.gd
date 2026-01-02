extends physics_item
@export var weapon_model : Node3D
@export var muzzle_flash : OmniLight3D
@export var gun_ray : RayCast3D
var mag_size = 13
var ammunition = mag_size
var animation_player : AnimationPlayer

func _ready() -> void:
	animation_player = weapon_model.get_child(1)
	
func play_equip_animation():
	animation_player.play("p2000_equip")
	get_tree().call_group("player_animations", "play_arm_animation", "p2000_equip")
	
func  play_store_animation():
	get_tree().call_group("player_animations", "play_arm_animation", "p2000_store")
	
func object_function():
	if equip_timer.is_stopped() and ammunition:
		ammunition -= 1
		animation_player.seek(0)
		animation_player.play("fire")
		get_tree().call_group("player_animations", "play_arm_animation_from_start", "p2000_fire")
		check_hit()
		effects()
		muzzle_flash.omni_range = 1000
		await get_tree().create_timer(0.1).timeout
		muzzle_flash.omni_range = 0
	
func object_reload():
	get_tree().call_group("player_animations", "play_arm_animation", "p2000_reload")
	animation_player.play("gun_rigAction")
	await animation_player.animation_finished
	ammunition = mag_size

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
var random_number = RandomNumberGenerator.new()
@export var ejection_area : Node3D
@onready var ejection_dir_node : Node3D = ejection_area.get_child(0)
var bullet_casing = preload("res://particle_effects/bullet_casings.tscn")
func effects():
	var bullet_casing_clone : RigidBody3D = bullet_casing.instantiate()
	add_child(bullet_casing_clone)
	bullet_casing_clone.global_position = ejection_area.global_position
	bullet_casing_clone.linear_velocity = (ejection_dir_node.global_position - bullet_casing_clone.global_position).normalized() * random_number.randf_range(1.0, 3.0)
	bullet_casing_clone.angular_velocity = Vector3(0, 10, 0)
	bullet_casing_clone.reparent(root_node.particles)
