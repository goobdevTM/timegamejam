extends Control

func _ready() -> void:
	for control : Control in get_children():
		if control is Button:
			control.connect("mouse_entered", button_hover.bind(control))
			control.connect("mouse_exited", button_normal.bind(control))
			control.connect("button_down", button_pressed.bind(control))
			control.connect("button_up", button_hover.bind(control))
			
func button_hover(button : Button) -> void:
	
	
func button_normal(button : Button) -> void:
	pass
	
func button_pressed(button : Button) -> void:
	pass
