extends Node2D

@export var connection_name: String

func _ready() -> void:
	GlobalEventSystem.suscribe(self, "_on_global_event")

func toggle_to(value: bool):
	$FlagArea/CollisionShape2D.set_deferred("disabled", not value)
	var sprite: Sprite2D = $Sprite2D
	if value:
		sprite.region_rect.position.x = 0
	else:
		sprite.region_rect.position.x = 16

func toggle():
	toggle_to($FlagArea/CollisionShape2D.disabled)

func _on_flag_area_body_entered(body: Node2D) -> void:
	if body is APlayer:
		toggle_to(false)

func _on_global_event(event: GlobalEventSystem.GameEvent, message: Dictionary):
	if event == GlobalEventSystem.GameEvent.GE_INTERACTION:
		if message.get("connection") == connection_name:
			toggle()
