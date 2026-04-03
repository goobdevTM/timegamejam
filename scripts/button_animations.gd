extends Control

@export var offset : Vector2 = Vector2(0.5,0.5)

func _ready() -> void:
	for control : Control in get_children():
		if control is Button:
			var button_size : Vector2 = Vector2(0,0)
			if get_node(self.get_path()) is BoxContainer:
				button_size = Vector2(size.x, control.custom_minimum_size.y)
			else:
				button_size = Vector2(control.size.x, control.size.y)
			control.pivot_offset = Vector2(button_size.x * offset.x, button_size.y * offset.y)
			control.connect("mouse_entered", button_hover.bind(control))
			control.connect("mouse_exited", button_normal.bind(control))
			control.connect("button_down", button_pressed.bind(control))
			control.connect("button_up", button_hover.bind(control))
			
func button_hover(button : Button) -> void:
	var tween : Tween = create_tween()
	tween.tween_property(button, "scale", Vector2(1.05,1.05), 0.1)
	
func button_normal(button : Button) -> void:
	var tween : Tween = create_tween()
	tween.tween_property(button, "scale", Vector2(1,1), 0.1)
	
func button_pressed(button : Button) -> void:
	var tween : Tween = create_tween()
	tween.tween_property(button, "scale", Vector2(0.98,0.98), 0.1)
