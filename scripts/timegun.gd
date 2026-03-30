extends Node2D
class_name Gun

@onready var sprite: Sprite2D = $Sprite
@onready var player: Player = $".."

@export var offset : Vector2 = Vector2(-1,2)
@export var pivot_offset : Vector2 = Vector2(-3,-3)

var look_at_mouse_strength : float = 1
var facing_direction : int = 0

func _ready() -> void:
	position = offset

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var old_rotation : float = rotation
	look_at(get_global_mouse_position())
	look_at_mouse_strength = clamp(look_at_mouse_strength, 0, 1)
	rotation = lerp(old_rotation, rotation, look_at_mouse_strength)
	look_at_mouse_strength += delta
	sprite.position.x = pivot_offset.x
	if get_global_mouse_position().x > global_position.x:
		facing_direction = 1
		sprite.flip_v = false
		sprite.position.y = -16 - pivot_offset.y
	else:
		facing_direction = -1
		sprite.flip_v = true
		sprite.position.y = pivot_offset.y
	
	if get_global_mouse_position().x > player.global_position.x:
		position.x = offset.x
		get_parent().move_child(self, 1)
	else:
		get_parent().move_child(self, 0)
		position.x = -offset.x
		
	if Input.is_action_just_pressed("shoot"):
		look_at_mouse_strength = 0
		if facing_direction == 1:
			rotation -= 0.5
		else:
			rotation += 0.5
