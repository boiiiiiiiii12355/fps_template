extends Node3D

#may change depending on blender format
var skeleton : Skeleton3D = self.get_child(0).get_child(0)
var head

func _ready() -> void:
	head = skeleton.get

func head_point_to():
	pass
