extends Node2D

var speed : float = 30
var direction : Vector2:
	set(value):
		direction = value

func _physics_process(delta):	
	position += direction * speed * delta

func _on_lifetime_timer_timeout() -> void:
	queue_free()
