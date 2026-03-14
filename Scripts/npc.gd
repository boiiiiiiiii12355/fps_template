extends Node3D
class_name npc_base

func _ready() -> void:
	animationplayer.play("idle")
#absolute basics like dialogue are included here

@export var animationplayer : AnimationPlayer
@export var head : Node3D
var dialogue_data_block : PackedStringArray = [
"oi mate",
"what are ya buyin?",
"shop.open",
"shop.close",
"why your hair so short? later no one want you"
]

var test_array = ["apple, orange, memes"]

@export var head_look_at : Node3D
@export var legs_look_at : Node3D
func look_at_(object : Object):
	var look_tween : Tween = get_tree().create_tween()
	look_tween.set_ease(Tween.EASE_IN_OUT)
	look_tween.set_trans(Tween.TRANS_QUAD)
	look_tween.tween_property(head_look_at, "global_position", object.global_position, 1)
	look_tween.tween_property(legs_look_at, "global_position", object.global_position, 1.5)
