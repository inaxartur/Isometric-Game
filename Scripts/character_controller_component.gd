extends Node2D
class_name CharacterControllerComponent

@export var SPEED = 100.0
@export var ACCEL = 10.0
@export var FRICTION = 15.0
@export var direction = Vector2.ZERO
@export var is_dodging : bool
@export var character : CharacterBody2D
@export var dodge_cooldown : Timer
@export var attack_cooldown : Timer
@export var stamina_bar : ProgressBar
@export var is_attacking = false

const max_stamina := 100.0
var stamina : float

var last_direction = Vector2.ZERO

# Values that can be changed:
var dodge_stamina_cost := 27.5
var attack_stamina_cost := 17.5
var stamina_regen_rate := 15.0


## Ready function ##
func _ready() -> void:
	is_dodging = false
	assert(attack_cooldown, "No Attack Timer provided in CharacterControllerComponent")
	assert(dodge_cooldown, "No Dodge Timer provided in CharacterControllerComponent")
	assert(character, "No CharacterBody2D provided in CharacterControllerComponent!")
	stamina = max_stamina
	set_stamina_label()


## physics process function
func _physics_process(delta: float) -> void:
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	inputHandler()
	staminaRegen(delta)
	movementHandler(delta)
	character.move_and_slide()


## Functions
func set_stamina_label() -> void:
	stamina_bar.value = stamina
 
func staminaRegen(delta: float) -> void:
	set_stamina_label()
	if (stamina < max_stamina) and !is_dodging and !is_attacking:
		stamina += (delta * stamina_regen_rate)

func dodge() -> void:
	if stamina - dodge_stamina_cost < 0 or !dodge_cooldown.is_stopped() or direction == Vector2.ZERO:
		pass
	else:
		stamina -= dodge_stamina_cost
		dodge_cooldown.start()
		is_dodging = true

func attack() -> void:
	if stamina - attack_stamina_cost < 0 or !attack_cooldown.is_stopped():
		pass
	else:
		stamina -= attack_stamina_cost
		attack_cooldown.start()
		is_attacking = true

func inputHandler() -> void:
	if Input.is_action_just_pressed("dodge") and !is_dodging:
		dodge()
	if Input.is_action_just_pressed("attack") and !is_attacking and !is_dodging:
		attack()

func movementHandler(delta: float) -> void:
	if is_dodging:
		character.velocity = lerp(character.velocity, last_direction * SPEED, ACCEL * delta)
	else:
		if direction != Vector2.ZERO:
			character.velocity = lerp(character.velocity, direction * SPEED, ACCEL * delta)
			last_direction = direction
		else:
			character.velocity = lerp(character.velocity, Vector2.ZERO, FRICTION * delta)


func _on_attack_cooldown_timeout() -> void:
	attack_cooldown.stop()

func _on_dodge_cooldown_timeout() -> void:
	dodge_cooldown.stop()
