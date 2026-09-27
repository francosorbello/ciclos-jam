@tool
extends Node2D
class_name Door

enum DoorDirection {
    DD_HORIZONTAL,
    DD_VERTICAL
}

@export var connection_name: String

@export var start_opened: bool = false:
    set(value):
        start_opened = value
        if Engine.is_editor_hint() and horizontal_closed:
            if start_opened:
                open()
            else:
                close()

@export var door_direction: DoorDirection:
    set(value):
        door_direction = value
        if Engine.is_editor_hint() and horizontal_closed:
            if start_opened:
                open()
            else:
                close()

@export_category("Sprites Horizontal")
@export var horizontal_open: Texture2D
@export var horizontal_closed: Texture2D

@export_category("Sprites Vertical")
@export var vertical_open: Texture2D
@export var vertical_closed: Texture2D

var is_open: bool = false

func _ready() -> void:
    if Engine.is_editor_hint():
        return

    if start_opened:
        open()
    else:
        close()
    
    $InteractionToggleComponent.connection_name = connection_name

func toggle():
    if is_open:
        close()
    else:
        open()

func open():
    $Sprite2D.texture = _get_open_sprite()
    $StaticBody2D/CollisionShape2D.disabled = true
    is_open = true

func close():
    $Sprite2D.texture = _get_closed_sprite()
    $StaticBody2D/CollisionShape2D.disabled = false
    is_open = false

func _get_closed_sprite():
    match door_direction:
        DoorDirection.DD_HORIZONTAL:
            return horizontal_closed
        DoorDirection.DD_VERTICAL:
            return vertical_closed
    return null

func _get_open_sprite():
    match door_direction:
        DoorDirection.DD_HORIZONTAL:
            return horizontal_open
        DoorDirection.DD_VERTICAL:
            return vertical_open
    return null


func _on_interaction_toggle_component_enable() -> void:
    toggle()


func _on_interaction_toggle_component_disable() -> void:
    toggle()
