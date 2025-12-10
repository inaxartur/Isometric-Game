extends Node2D 
class_name Player


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
