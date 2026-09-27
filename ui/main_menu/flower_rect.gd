extends TextureRect

var center: Vector2

func _ready() -> void:
    center = Vector2(get_viewport_rect().size.x/2,get_viewport_rect().size.y/2)

func _process(delta: float) -> void:
    var offset = Vector2.ZERO - get_global_mouse_position() * 0.1
    offset_transform_position = FreyaMath.lerp_exp_decay(offset_transform_position, offset, 10, delta)