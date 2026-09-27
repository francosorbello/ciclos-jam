extends Resource
class_name GameScreenResource

enum GameScreenType{
    UI,
    LEVEL
}

enum TransitionType {
    NONE,
    FADE,
}

@export var name: String
@export var scene: PackedScene
@export var type: GameScreenType
@export var transition_type: TransitionType = TransitionType.FADE