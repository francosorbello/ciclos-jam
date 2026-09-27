@tool
extends Node2D

@export_category("Flag specific")
@export var next_screen_name: String
@export var start_enabled: bool = true:
	set(value):
		start_enabled = value
		if Engine.is_editor_hint() and enabled_texture:
			if value:
				$Sprite2D.texture = enabled_texture
			else:
				$Sprite2D.texture = disabled_texture

@export_category("Connections")
@export var connection_name: String

@export_category("Sprites")
@export var enabled_texture: Texture2D
@export var disabled_texture: Texture2D

func _ready() -> void:
	$WinArea.next_screen_name = next_screen_name
	if start_enabled:
		enable()
	else:
		disable()
	$InteractionToggleComponent.connection_name = connection_name

func enable():
	$WinArea.enable()
	$Sprite2D.texture = enabled_texture

func disable():
	$WinArea.disable()
	$Sprite2D.texture = disabled_texture

func _on_interaction_toggle_component_enable() -> void:
	enable()

func _on_interaction_toggle_component_disable() -> void:
	disable()
