extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var damage = 5

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if randi_range(1, 200) == 14:
		velocity.y = JUMP_VELOCITY / 5

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = randi_range(-5, 5)
	if direction == 5:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
