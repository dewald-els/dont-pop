extends Node


@onready var play_button: GameButton = %PlayButton
@onready var quit_button: GameButton = %QuitButton
@onready var high_scores_button: GameButton = %HighScoresButton
@onready var options_button: GameButton = %OptionsButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if OS.get_name() == "Web":
		quit_button.visible = false
	
	play_button.did_press.connect(start_game)
	quit_button.did_press.connect(quit_game)
	high_scores_button.did_press.connect(show_high_scores)
	options_button.did_press.connect(_on_options_pressed)
	MusicPlayer.play_game_song()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		play_button.pressed.emit()
	elif event.is_action_pressed("ui_cancel"):
		quit_button.pressed.emit()

func quit_game() -> void:
	get_tree().quit()

func start_game() -> void:
	get_tree().change_scene_to_file("res://scenes/main/main.tscn")

func show_high_scores() -> void:
	get_tree().change_scene_to_file("res://scenes/leaderboard/leaderboard_screen.tscn")


func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/options/options_screen.tscn")
