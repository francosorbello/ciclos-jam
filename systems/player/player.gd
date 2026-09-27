extends CharacterBody2D
class_name APlayer

@export var speed : float = 50
@export var accel : float = 2

var sprites: Array[PlayerSprite] = []

func _ready() -> void:
	for child in get_children():
		if child is PlayerSprite:
			sprites.append(child)

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("move_left","move_right","move_up","move_down") 
	_handle_animation(direction)

	velocity = FreyaMath.lerp_exp_decay(velocity,direction * speed, 10, delta * accel)
	move_and_slide()

func _handle_animation(dir_input: Vector2):
	for sprite in sprites:
		sprite.animate_by(dir_input)	

	
func _on_hitbox_on_hit() -> void:
	$SFXBuilderSpawner.create().run()
	get_tree().create_timer(1).timeout.connect(func(): GlobalSignal.restart_level_requested.emit())
	queue_free()
