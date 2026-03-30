extends Node2D
class_name MovingPlatform

@export var size : int = 32
@export var points : Array[Vector2] = [Vector2(-16, 0), Vector2(16, 0)]
@export var speed : float = 20

@onready var sprites: Node2D = $Sprites
@onready var collision: CollisionShape2D = $CharacterBody2D/CollisionShape2D

@export var cur_point : int = 0

var start_pos : Vector2


func _ready() -> void:
	sprites.get_child(0).position.x = -(size / 2) - 16
	sprites.get_child(1).position.x = -(size / 2)
	sprites.get_child(1).size.x = size
	sprites.get_child(2).position.x = (size / 2)
	collision.shape = collision.shape.duplicate()
	collision.shape.size.x = size + 8
	start_pos = position
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position += (points[(cur_point + 1) % len(points)] - position + start_pos).normalized() * delta * speed
	if position.distance_to(points[(cur_point) % len(points)] + start_pos) > points[(cur_point + 1) % len(points)].distance_to(points[(cur_point) % len(points)]):
		cur_point += 1
