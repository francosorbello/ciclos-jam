extends CharacterBody2D

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

	position.x = wrapf(position.x, 0, 128)
	position.y = wrapf(position.y, 0, 128)


func _handle_animation(dir_input: Vector2):
	for sprite in sprites:
		sprite.animate_by(dir_input)	

	
