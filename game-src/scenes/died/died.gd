extends Node

@onready var score_label: Label = %ScoreLabel
@onready var try_again_button: GameButton = %TryAgainButton
@onready var quit_button: GameButton = %QuitButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	MusicPlayer.play_died_song()
	try_again_button.did_press.connect(on_try_again_pressed)
	quit_button.did_press.connect(on_quit_pressed)
	score_label.text = "You scored " + str(ScoreKeeper.score)
	

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		try_again_button.pressed.emit()
	elif event.is_action_pressed("ui_cancel"):
		quit_button.pressed.emit()


func start_game() -> void:
	get_tree().change_scene_to_file("res://scenes/main/main.tscn")
	
	
func quit_game() -> void:
	get_tree().change_scene_to_file("res://scenes/screens/menu/menu.tscn")


func on_try_again_pressed() -> void:
	start_game()

func on_quit_pressed() -> void:
	quit_game()
