extends Node

@export var values: SFXBuilderResource
@export var sprite: Sprite2D

func create() -> SfxBuilder:
    var sfx_builder =  SfxBuilder.new()
    if sprite != null:
        sfx_builder.set_sprite(sprite.texture)
    return sfx_builder.set_target(get_parent()).set_values(values)