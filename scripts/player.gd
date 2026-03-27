extends CharacterBody2D

@onready var camera: Camera2D = $"../Camera"

const SPEED : float = 160.0
const JUMP_VELOCITY : float = -250.0

var coyote_time : float = 0
var buffer_jump : float = 0
var dash_time : float = 0
var dash_cooldown : float = 0

var jumping : bool = false

var direction : float = 0
var last_direction : float = 0
var direction_facing : float = 0
var last_movement_length : float = 0

var double_jump : int = 1



func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		if jumping:
			velocity += (get_gravity() / 1.15) * delta
		else:
			velocity += get_gravity() * delta

	buffer_jump -= delta
	coyote_time -= delta
	dash_time -= delta
	dash_cooldown -= delta

	# Handle jump.
	if is_on_floor():
		coyote_time = 0.12
		double_jump = 1
	if Input.is_action_just_pressed("jump"):
		buffer_jump = 0.08
	if buffer_jump > 0 and (coyote_time > 0 or double_jump > 0):
		velocity.y = JUMP_VELOCITY
		jumping = true
		if not coyote_time > 0:
			double_jump -= 1
		buffer_jump = 0
		coyote_time = 0
	if jumping and not Input.is_action_pressed("jump") and velocity.y < -6:
		velocity.y /= 2
		jumping = false
	

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_axis("left", "right")
	if direction:
		if not last_direction and dash_time > 0 and direction_facing == direction and dash_cooldown <= 0 and last_movement_length <= 0.2:
			velocity.x = direction * 1250
			dash_cooldown = 0.25
			if velocity.y > 0:
				velocity.y /= 4
		dash_time = 0.15
		velocity.x = lerp(velocity.x, direction * SPEED, delta * 20)
		direction_facing = direction
		if not last_direction:
			last_movement_length = 0
		last_movement_length += delta
	else:
		velocity.x = lerp(velocity.x, 0.0, delta * 15)
		
	last_direction = direction
	
	camera.position = lerp(camera.position, position, delta * 8)

	move_and_slide()
