extends AudioStreamPlayer

@export var game_music: AudioStream
@export var poem_music: AudioStream # Unused music.
@export var main_menu_music: AudioStream # Unused music.

var tween: Tween

func play_music():
	transition_to(game_music)
	
func play_level():
	transition_to(game_music)

func play_poem():
	transition_to(poem_music)

func transition_to(song: AudioStream):
	_on_transition_finished(song)

func _on_transition_finished(song):
	stop()
	stream = song
	play()
