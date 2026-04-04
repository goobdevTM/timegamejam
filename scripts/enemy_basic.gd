extends CharacterBody2D

class_name Enemy

@onready var ground_raycast: RayCast2D = $Raycasts/RayCast2D
@onready var above_raycast: RayCast2D = $Raycasts/RayCast2D2
@onready var short_above_raycast: RayCast2D = $Raycasts/RayCast2D3
@onready var detect_wall: Area2D = $Raycasts/Area2D
@onready var player: Player = $"../Player"
@onready var raycasts: Node2D = $Raycasts


@export var SPEED : float = 80.0
const JUMP_VELOCITY : float = -220.0
const SHORT_JUMP_VELOCITY : float = -150.0

@export var damage : float = 5
@export var can_jump : bool = true
var direction : float = 0
var walls : int = 0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	ground_raycast.force_raycast_update()
	above_raycast.force_raycast_update()
	if can_jump:
		if is_on_floor() and (not ground_raycast.is_colliding() or (walls > 0 and (not above_raycast.is_colliding() or (not short_above_raycast.is_colliding()))) or (abs(global_position.x - player.global_position.x) < 20)):
			if not short_above_raycast.is_colliding() and not (abs(global_position.x - player.global_position.x) < 20) and ground_raycast.is_colliding():
				velocity.y = SHORT_JUMP_VELOCITY
			else:
				velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if global_position.distance_to(player.global_position) <= 180:
		if player.global_position.x > global_position.x:
			direction = 1
		else:
			direction = -1
	else:
		direction = 0
	if direction:
		if direction > 0:
			raycasts.scale.x = 1
		else:
			raycasts.scale.x = -1
		velocity.x = lerp(velocity.x, direction * SPEED, delta * 12)
	else:
		velocity.x = lerp(velocity.x, 0.0, delta * 8)

	move_and_slide()


func _on_wall_body_entered(body: Node2D) -> void:
	walls += 1


func _on_wall_body_exited(body: Node2D) -> void:
	walls -= 1
