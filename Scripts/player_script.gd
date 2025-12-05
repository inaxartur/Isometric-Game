extends CharacterBody2D

@export var SPEED = 100.0
@export var ACCEL = 10.0
@export var FRICTION = 15.0
@export var direction = Vector2.ZERO
@export var is_dodging : bool

var last_direction = Vector2.ZERO

func _ready() -> void:
	is_dodging = false

func _physics_process(delta: float) -> void:
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	print(is_dodging)
	
	if (Input.is_action_just_pressed("dodge") && !is_dodging):
		is_dodging = true

	if is_dodging:
		velocity = lerp(velocity, last_direction * SPEED, ACCEL * delta)
	else:
		if direction != Vector2.ZERO:
			velocity = lerp(velocity, direction * SPEED, ACCEL * delta)
			last_direction = direction
		else:
			velocity = lerp(velocity, Vector2.ZERO, FRICTION * delta)

	move_and_slide()
