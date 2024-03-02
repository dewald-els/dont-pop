extends Node

@onready var score_label: Label = %ScoreLabel
@onready var try_again_button: Button = %TryAgainButton
@onready var quit_button: Button = %QuitButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	try_again_button.connect("did_press", on_try_again_pressed)
	quit_button.connect("did_press", on_quit_pressed)
	
	score_label.text = "You scored " + str(ScoreKeeper.score)
	

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		try_again_button.emit_signal("pressed")
	elif event.is_action_pressed("ui_cancel"):
		quit_button.emit_signal("pressed")


func start_game() -> void:
	get_tree().change_scene_to_file("res://scenes/main/main.tscn")
	
	
func quit_game() -> void:
	get_tree().change_scene_to_file("res://scenes/menu/menu.tscn")


func on_try_again_pressed() -> void:
	start_game()

func on_quit_pressed() -> void:
	quit_game()
