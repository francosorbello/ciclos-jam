extends Node

@export var screens_container: GameScreenContainerResource
@export var game_level_container: PackedScene
@export var initial_screen_name: InitialScreenNameResource

var game_level_container_scene: Node

var _current_screen: Node

var _current_level: GameScreenResource

var is_transitioning: bool = false

func _ready() -> void:
	$MusicManager.play_music()
	transition_to(initial_screen_name.initial_screen_name)
	GlobalSignal.restart_level_requested.connect(restart_current_level)
	GlobalSignal.change_scene_requested.connect(transition_to)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("restart") and _current_level:
		restart_current_level()

func transition_to(level_name: String):
	if is_transitioning:
		print("Already transitioning")
		return
	var screen := screens_container.get_by_name(level_name)
	assert(screen != null, "No hay escena llamada "+level_name)

	is_transitioning = true
	#change_music(screen.type)
	if screen.transition_type == GameScreenResource.TransitionType.FADE:
		await get_tree().create_timer($TransitionScreen.fade_in()).timeout

	if screen.type == GameScreenResource.GameScreenType.LEVEL:
		transition_to_level(screen)
	elif screen.type == GameScreenResource.GameScreenType.UI:
		transition_to_ui(screen)
	
	var wait_for = 1
	if screen.transition_type == GameScreenResource.TransitionType.FADE:	
		wait_for = $TransitionScreen.fade_out()

	get_tree().create_timer(wait_for).timeout.connect(func(): is_transitioning = false)

func transition_to_ui(ui_scene: GameScreenResource):
	if _current_screen:
		_current_screen.queue_free()

	_current_level = null
	await get_tree().process_frame

	_current_screen = ui_scene.scene.instantiate()
	add_child(_current_screen)

func transition_to_level(level: GameScreenResource):
	if _current_screen:
		_current_screen.queue_free()
	
	await get_tree().process_frame

	_current_screen = game_level_container.instantiate()
	add_child(_current_screen)
	var _level_scene = level.scene.instantiate()
	_current_screen.add_level(_level_scene)
	_current_level = level

func restart_current_level():
	if _current_level:
		transition_to(_current_level.name)

func change_music(type: GameScreenResource.GameScreenType):
	match type:
		GameScreenResource.GameScreenType.UI:
			$MusicManager.play_poem()
		GameScreenResource.GameScreenType.LEVEL:
			$MusicManager.play_level()
		
