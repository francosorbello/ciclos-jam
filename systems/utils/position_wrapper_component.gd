extends Node

@export var screen_width: float = 128
@export var screen_height: float = 128

var target: Node2D

func _ready() -> void:
	target = get_parent() as Node2D

func _physics_process(_delta: float) -> void:
	target.global_position.x = wrapf(target.global_position.x, 0, screen_width)
	target.global_position.y = wrapf(target.global_position.y, 0, screen_height)
