extends Resource
class_name GameScreenContainerResource

@export var screens: Array[GameScreenResource]

func get_by_name(name: String) -> GameScreenResource:
    for screen in screens:
        if screen.name == name:
            return screen
    return null