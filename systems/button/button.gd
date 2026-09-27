extends Area2D

@export var connection_name: String = ""

@export_category("Textures")
@export var pushed_texture: Texture2D
@export var up_texture: Texture2D

@export_category("Sound")
@export var pushed_sound: AudioStream
@export var up_sound: AudioStream


var _disabled: bool = false:
	set(new_value):
		if new_value:
			$Sprite2D.texture = pushed_texture
			$AudioStreamPlayer2D.stream = pushed_sound
			$AudioStreamPlayer2D.play()
		else:
			$Sprite2D.texture = up_texture
			$AudioStreamPlayer2D.stream = up_sound
			$AudioStreamPlayer2D.play()
		_disabled = new_value
		

func _ready() -> void:
	assert(connection_name != "", "No hay connection_name en "+name)

func _on_body_entered(body: Node2D) -> void:
	if _disabled:
		return
	if body is APlayer:
		GlobalEventSystem.emit(GlobalEventSystem.GameEvent.GE_INTERACTION, {"connection": connection_name})
		_disabled = true


func _on_body_exited(body: Node2D) -> void:
	if body is APlayer and _disabled:
		_disabled = false
