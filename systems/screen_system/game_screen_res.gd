extends Resource
class_name GameScreenResource

enum GameScreenType{
    UI,
    LEVEL
}

@export var name: String
@export var scene: PackedScene
@export var type: GameScreenType