extends Node3D

@export var subject_205_anim : AnimationPlayer
@export var camera : Camera3D
var cam_default_pos

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cam_default_pos = camera.global_position
	subject_205_anim.play("default_pose")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
