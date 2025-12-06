extends Node2D
class_name AttackComponent

@export var attack_damage := 10.0
@export var character : CharacterControllerComponent

func _on_area_2d_area_entered(area: Area2D) -> void:
	if character.is_attacking and area.is_in_group("hitbox"):
		print('should attack')
		#area.take_damage()
