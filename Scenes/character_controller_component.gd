extends Node2D
class_name CharacterControllerComponent

@export var SPEED = 100.0
@export var ACCEL = 10.0
@export var FRICTION = 15.0
@export var direction = Vector2.ZERO
@export var is_dodging : bool
@export var character : CharacterBody2D

var last_direction = Vector2.ZERO

func _ready() -> void:
	is_dodging = false
	assert(character, "No CharacterBody2D provided in CharacterControllerComponent!")

func _physics_process(delta: float) -> void:
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	if (Input.is_action_just_pressed("dodge") && !is_dodging):
		is_dodging = true

	if is_dodging:
		character.velocity = lerp(character.velocity, last_direction * SPEED, ACCEL * delta)
	else:
		if direction != Vector2.ZERO:
			character.velocity = lerp(character.velocity, direction * SPEED, ACCEL * delta)
			last_direction = direction
		else:
			character.velocity = lerp(character.velocity, Vector2.ZERO, FRICTION * delta)
	character.move_and_slide()
