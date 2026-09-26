extends Node2D
class_name PlayerSprite

@onready var anim_player: AnimationPlayer = $AnimationPlayer

func animate_by(direction: Vector2):
	_handle_animation(direction)

func _handle_animation(dir_input: Vector2):
	if dir_input.is_zero_approx():
		if anim_player.current_animation != "idle":
			anim_player.play("idle")
	else:
		if anim_player.current_animation != "moving":
			anim_player.play("moving")
	
