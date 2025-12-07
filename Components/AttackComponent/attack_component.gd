extends Node2D
class_name AttackComponent

@export var attack_damage := 10.0
@export var character : CharacterControllerComponent
@export var attack_component : AttackComponent

func _on_area_2d_area_entered(area: Area2D) -> void:
	#print_debug(area.get_groups(), ", ", character.is_attacking)
	if character.is_attacking and area.is_in_group("hitbox"):
		area.take_damage(attack_component)
