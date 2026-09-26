extends Area2D

signal on_hit

func _on_area_entered(area: Area2D) -> void:
    if area is Hurtbox:
        on_hit.emit()
