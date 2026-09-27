extends Node2D

var speed : float = 30
var direction : Vector2:
	set(value):
		direction = value

func _physics_process(delta):	
	position += direction * speed * delta

func _on_lifetime_timer_timeout() -> void:
	queue_free()

func _on_projectile_area_body_entered(_body: Node2D) -> void:
	$AudioStreamPlayer2D.play()
	await $AudioStreamPlayer2D.finished
	queue_free()
	pass # Replace with function body.
