extends AudioStreamPlayer

@export var game_music: AudioStream
@export var poem_music: AudioStream
@export var main_menu_music: AudioStream

var tween: Tween

func play_level():
    transition_to(game_music)

func play_poem():
    transition_to(poem_music)

func transition_to(song: AudioStream):
    if tween != null:
        tween.kill()
    
    tween = create_tween()
    tween.tween_property(self, "volume_db", -80, 1).finished.connect(_on_transition_finished.bind(song))

func _on_transition_finished(song):
    stop()
    volume_db = 0
    stream = song
    play()