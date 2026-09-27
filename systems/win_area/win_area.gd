extends Area2D

@export var next_screen_name: String

func enable():
    $CollisionShape2D.set_deferred("disabled", false)

func disable():
    $CollisionShape2D.set_deferred("disabled", true)


func _on_body_entered(body: Node2D):
    if body is APlayer:
        $CollisionShape2D.set_deferred("disabled", true)
        GlobalSignal.change_scene_requested.emit(next_screen_name)