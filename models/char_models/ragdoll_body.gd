extends Node3D
class_name ragdoll
@export var skeleton : Skeleton3D
@export var physics_bone : PhysicalBoneSimulator3D
@export var head_tracker : BoneAttachment3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	
func start_phy():
	visible = true
	skeleton.show_rest_only = false
	physics_bone.physical_bones_start_simulation()
