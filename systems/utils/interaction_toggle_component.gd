extends Node

var connection_name: String

signal enable
signal disable

var _enabled: bool = false

func _ready() -> void:
    GlobalEventSystem.suscribe(self, "_on_global_event")

func _on_global_event(event: GlobalEventSystem.GameEvent, message: Dictionary):
    if event == GlobalEventSystem.GameEvent.GE_INTERACTION:
        if message.get("connection") == connection_name:
            _enabled = not _enabled
            if _enabled:
                enable.emit()
            else:
                disable.emit()