extends Node

@export var values: SFXBuilderResource

func create() -> SfxBuilder:
    var sfx_builder =  SfxBuilder.new()
    return sfx_builder.set_target(get_parent()).set_values(values)