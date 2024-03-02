extends Node


@onready var play_button: Button = %PlayButton
@onready var quit_button: Button = %QuitButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play_button.connect("did_press", start_game)
	quit_button.connect("did_press", quit_game)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		play_button.emit_signal("pressed")
	elif event.is_action_pressed("ui_cancel"):
		quit_button.emit_signal("pressed")

func quit_game() -> void:
	get_tree().quit()

func start_game() -> void:
	get_tree().change_scene_to_file("res://scenes/main/main.tscn")
