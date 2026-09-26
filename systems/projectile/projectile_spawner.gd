@tool
extends Node2D

enum ShootDirection {
	SD_UP,
	SD_DOWN,
	SD_LEFT,
	SD_RIGHT
}

@export var projectile_scene : PackedScene
@export var spawn_interval : float = 2
@export var override_speed : bool = false
@export var override_speed_value : float = 100
@export var shoot_direction: ShootDirection:
	set(value):
		shoot_direction = value
		if Engine.is_editor_hint():
			_set_sprite_for(_dir_to_vector(value))
@export var autostart = false

@export_category("Interactions")
@export var connection_name: String

@export_category("Sprites")
@export var up_texture: Texture2D
@export var down_texture: Texture2D
@export var right_texture: Texture2D

func _ready():
	if Engine.is_editor_hint():
		return
	if autostart:
		$SpawnIntervalTimer.start(spawn_interval)
	_set_sprite_for(_dir_to_vector(shoot_direction))
	$InteractionToggleComponent.connection_name = connection_name


func _set_sprite_for(dir: Vector2):
	if dir.x < 0:
		$Sprite2D.texture = right_texture
		$Sprite2D.flip_h = true
	elif dir.x > 0:
		$Sprite2D.texture = right_texture
		$Sprite2D.flip_h = false
	elif dir.y < 0:
		$Sprite2D.texture = up_texture
	elif dir.y > 0:
		$Sprite2D.texture = down_texture


func _dir_to_vector(dir: ShootDirection) -> Vector2:
	match dir:
		ShootDirection.SD_UP:
			return Vector2.UP
		ShootDirection.SD_DOWN:
			return Vector2.DOWN
		ShootDirection.SD_LEFT:
			return Vector2.LEFT
		ShootDirection.SD_RIGHT:
			return Vector2.RIGHT
	
	return Vector2.ZERO
	
func _dir_to_shoot_pos(dir: ShootDirection) -> Vector2:
	return _dir_to_vector(dir) * 8

func _on_spawn_interval_timer_timeout() -> void:
	spawn_projectile()
	pass # Replace with function body.

func spawn_projectile():
	var new_projectile = projectile_scene.instantiate()
	add_child(new_projectile)
	new_projectile.direction = _dir_to_vector(shoot_direction)
	new_projectile.position = _dir_to_shoot_pos(shoot_direction)
	if override_speed:
		new_projectile.speed = override_speed_value


func _on_interaction_toggle_component_enable() -> void:
	spawn_projectile()
	$SpawnIntervalTimer.start(spawn_interval)


func _on_interaction_toggle_component_disable() -> void:
	$SpawnIntervalTimer.stop()
