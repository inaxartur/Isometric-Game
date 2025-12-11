# NON FUNCTIONATING #
# DO NOT USE #

extends Node2D
class_name EnemyComponent

@export var navigationAgent : NavigationAgent2D
@export var attackDistance := 20.0
@export var attack_cooldown : Timer
@export var is_attacking = false

const max_stamina := 100.0
var stamina : float

# Values that can be changed:
var attack_stamina_cost := 17.5
var stamina_regen_rate := 15.0


func _ready() -> void:
	assert(attack_cooldown, "No Attack Timer provided in EnemyComponent")
	stamina = max_stamina


func _process(delta: float) -> void:
	var range_to_player = sqrt(pow(global_position.x - navigationAgent.target_position.x, 2.0) + pow(global_position.y - navigationAgent.target_position.y, 2.0))
	
	if (range_to_player < attackDistance):
		pass


func attack() -> void:
	if stamina - attack_stamina_cost < 0 or !attack_cooldown.is_stopped():
		pass
	else:
		stamina -= attack_stamina_cost
		attack_cooldown.start()
		is_attacking = true
