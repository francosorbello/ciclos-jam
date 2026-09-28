extends Control

@export var next_scene_name: String

func _on_play_button_pressed() -> void:
	print(next_scene_name)
	GlobalSignal.change_scene_requested.emit(next_scene_name)


func _on_exit_button_pressed() -> void:
	if  OS.get_name() == "Web":
		return
	get_tree().quit()
