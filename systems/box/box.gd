extends Node2D
class_name Box

func _on_hitbox_on_hit() -> void:
	$SFXBuilderSpawner.create().run()
	queue_free()
