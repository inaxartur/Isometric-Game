extends Node2D
class_name HealthComponent

@export var MAX_HEALTH : float
@export var HEALTH_BAR : ProgressBar

var health : float

func _ready() -> void:
	health = MAX_HEALTH
	HEALTH_BAR.max_value = MAX_HEALTH
	set_health_label()


func damage(attack: AttackComponent):
	health -= attack.attack_damage
	HEALTH_BAR.visible = true
	set_health_label()
	
	if health <= 0:
		get_parent().queue_free()

func set_health_label() -> void:
	HEALTH_BAR.value = health
