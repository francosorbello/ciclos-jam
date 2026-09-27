extends Control

@export var transition_time: float = 1

func fade_in() -> float:
	var tween := create_tween()
	tween.tween_property($ColorRect.material, "shader_parameter/progress", 10, transition_time)
	return transition_time

func fade_out() -> float:
	var tween := create_tween()
	tween.tween_property($ColorRect.material, "shader_parameter/progress", 0, transition_time)
	return transition_time
