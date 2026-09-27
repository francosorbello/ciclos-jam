extends Control

@export var next_scene_name: String
@export var poem: PoemDialogueResource
@export_range(0,2,1) var index: int

@onready var text_container: Label = $Label

var can_exit = false

var play_voice_sound: bool = false

@onready var audio_player : AudioStreamPlayer = $AudioStreamPlayer

func _ready() -> void:
    await get_tree().create_timer(3).timeout
    text_container.visible_ratio = 0
    text_container.text = poem.lines[index]

    var tween := create_tween()
    play_voice_sound = true
    tween.tween_property(text_container, "visible_ratio", 1, 4).finished.connect(_on_text_finished)

func _process(_delta: float) -> void:
    if play_voice_sound and not audio_player.playing:
        audio_player.play()

    if can_exit and Input.is_action_pressed("continue"):
        GlobalSignal.change_scene_requested.emit(next_scene_name)
        can_exit = false

func _on_text_finished():
    can_exit = true
    play_voice_sound = false