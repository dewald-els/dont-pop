class_name MainGame
extends Node2D


func _ready() -> void:
	PlayerTracker.clear()
	MusicPlayer.play_game_song()
