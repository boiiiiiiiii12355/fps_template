extends Control
class_name shop_item_buttons

@export var button : Button

func rename_button(oname : String):
	self.name = oname
	button.text = oname

func animate_move(end_position : Vector2):
	var move_tween : Tween = self.create_tween()
	move_tween.tween_property(self, "position", end_position, 1)
	move_tween.set_ease(Tween.EASE_OUT)
