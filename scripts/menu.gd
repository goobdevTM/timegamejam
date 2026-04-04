extends Control

@onready var menu_background: Sprite2D = $MenuBackground


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	menu_background.position = lerp(menu_background.position, ((Vector2(320, 240) - get_global_mouse_position()) / 32) - Vector2(32, 32), delta * 4)
	menu_background.position.x = clamp(menu_background.position.x, -32, 0)
	menu_background.position.y = clamp(menu_background.position.y, -32, 0)

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")
