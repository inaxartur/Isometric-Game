extends Player
class_name VirtualPlayer

@export var nav : NavigationAgent2D
## Ready function ##
func _ready() -> void:
	super._ready()
	assert(nav, "No navigation agent provided!")
	
	

func actor_setup():
	# Wait for the first physics frame so the NavigationServer can sync.
	await get_tree().physics_frame
	# Now that the navigation map is no longer empty, set the movement target.
	set_movement_target(player.position)

func set_movement_target(movement_target: Vector2):
	nav.target_position = movement_target
	
## physics process function
func _physics_process(delta: float) -> void:
	staminaRegen(delta)
	movementHandler(delta)
	character.move_and_slide()

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
