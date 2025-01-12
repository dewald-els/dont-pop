class_name PlayerDeath
extends Node2D


@onready var animated_sprite: AnimatedSprite2D = %AnimatedSprite
@onready var death_sound_player: AudioStreamPlayer2D = %DeathSoundPlayer


func _ready() -> void:
	death_sound_player.play()
	animated_sprite.animation_finished.connect(_on_finished)
	
func _on_finished() -> void:
	await get_tree().create_timer(0.5).timeout
	
	if HighScoreManager.is_high_score(ScoreKeeper.score):
		Callable(load_enter_high_score).call_deferred()
	else:
		Callable(load_death_screen).call_deferred()


func load_death_screen() -> void:
	get_tree().change_scene_to_file("res://scenes/died/died.tscn")


func load_enter_high_score() -> void:
	get_tree().change_scene_to_file("res://scenes/screens/enter_high_score_screen/enter_high_score_screen.tscn")
