extends Node

func _ready() -> void:
	print(self.get_children())
	_init()

func play_sound(sound_name : String, pos):
	for i in sound_list.size():
		var sound : AudioStreamPlayer
		if sound_name == sound_list[i].name:
			sound = sound_list[i]
		else: 
			sound = null
			
		if sound:
			sound.pitch_scale = randf_range(1, 2)
			sound.play()
			print("sound played " + str(sound_name))
			
var sound_list : Array[Object]
func _init():
	for i in self.get_children():
		sound_list.resize(i.get_index() + 1)
		sound_list[i.get_index()] = get_child(i.get_index())
		print(sound_list)
