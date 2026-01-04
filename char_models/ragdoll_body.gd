extends Skeleton3D
@export var physics_bone : PhysicalBoneSimulator3D
@export var head : PhysicalBone3D
var hp = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bone_init()

func bone_init():
	for i : PhysicalBone3D in physics_bone.get_children():
		i.add_to_group("ragdoll")

@export var headshot_modi = 400 #percent
@export var bodyshot_modi = 100 #percent
func hit(hit_bone : PhysicalBone3D, base_damage : float):
	var modi_damage = base_damage
	
	if hit_bone == head:
		modi_damage *= headshot_modi / 100
		
	hp -= modi_damage
	print(modi_damage)
	print(hp)
	if hp <= 0:
		physics_bone.physical_bones_start_simulation()
