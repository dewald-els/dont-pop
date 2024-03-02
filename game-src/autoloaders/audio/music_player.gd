extends Node

@onready var stream_player: AudioStreamPlayer2D = %StreamPlayer

@export var game_song_stream: AudioStream;
@export var died_stream: AudioStream;

var playing: String

func play_game_song() -> void:
	if playing == "game_song_stream":
		return
	stream_player.stop()
	stream_player.stream = game_song_stream
	stream_player.play()
	playing = "game_song_stream"

func play_died_song() -> void:
	if playing == "died_stream":
		return
	stream_player.stop()
	stream_player.stream = died_stream
	stream_player.play()
	playing = "died_stream"
