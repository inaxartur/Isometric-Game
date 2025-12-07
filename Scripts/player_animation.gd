extends Node2D


@export var animation_tree: AnimationTree
@export var character_controller: CharacterControllerComponent

var last_facing_direction := Vector2.ZERO

func _ready() -> void:
	assert(character_controller, "No CharacterControllerComponent in player animation!")
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta: float) -> void:
	if character_controller.direction != Vector2.ZERO && character_controller.is_dodging == false:
		last_facing_direction = character_controller.direction
		animation_tree.set("parameters/walk/blend_position", last_facing_direction)
		animation_tree.set("parameters/idle/blend_position", last_facing_direction)
		animation_tree.set("parameters/attack/blend_position", last_facing_direction)
