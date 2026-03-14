extends Control
class_name shop_item_buttons

@export var button : Button
@export var parent : shop_ui
@export var item_name : String
@export var item_description : String

func rename_button(oname : String):
	self.name = oname
	button.text = oname

func animate_move(end_position : Vector2):
	var move_tween : Tween = self.create_tween()
	move_tween.tween_property(self, "position", end_position, 1)
	move_tween.set_ease(Tween.EASE_OUT)

func button_pressed():
	parent.item_info_show(item_name, item_description)
