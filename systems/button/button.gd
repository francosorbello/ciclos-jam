extends Area2D

@export var connection_name: String = ""

var _disabled: bool = false

func _ready() -> void:
	assert(connection_name != "", "No hay connection_name en "+name)

func _on_body_entered(body: Node2D) -> void:
	if _disabled:
		return
	if body is APlayer:
		GlobalEventSystem.emit(GlobalEventSystem.GameEvent.GE_BUTTON_PRESSED, {"connection": connection_name})
		_disabled = true


func _on_body_exited(body: Node2D) -> void:
	if body is APlayer and _disabled:
		_disabled = false
