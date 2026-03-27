extends Node2D

@export var to_outline : Array[Node2D] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(0.05).timeout
	make_outline()


func make_outline() -> void:
	for node : Node2D in to_outline:
		for x in range(-1, 2):
			for y in range(-1, 2):
				var new_node : Node2D = node.duplicate()
				add_child(new_node)
				new_node.position += Vector2(x,y)
				new_node.modulate.v -= 1
				new_node.show_behind_parent = true
				if x == 0 and y == 0:
					new_node.queue_free()
				node.add_child(new_node)
