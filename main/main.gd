extends Node

@export var game_level_container: PackedScene

var game_level_container_scene: Node

var _current_level: Node

func transition_to_level():
	if _current_level:
		_current_level.queue_free()
	
	await get_tree().process_frame

	_current_level = game_level_container.instantiate()
	add_child(_current_level)
	

