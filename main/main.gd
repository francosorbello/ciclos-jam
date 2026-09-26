extends Node

@export var screens_container: GameScreenContainerResource
@export var game_level_container: PackedScene
@export var initial_screen_name: InitialScreenNameResource

var game_level_container_scene: Node

var _current_creen: Node

func _ready() -> void:
	transition_to(initial_screen_name.initial_screen_name)

func transition_to(level_name: String):
	var screen := screens_container.get_by_name(level_name)
	assert(screen != null, "No hay escena llamada "+level_name)

	if screen.type == GameScreenResource.GameScreenType.LEVEL:
		transition_to_level(screen)

func transition_to_level(level: GameScreenResource):
	if _current_creen:
		_current_creen.queue_free()
	
	await get_tree().process_frame

	_current_creen = game_level_container.instantiate()
	add_child(_current_creen)
	var _level_scene = level.scene.instantiate()
	_current_creen.add_level(_level_scene)
	
