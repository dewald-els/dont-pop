extends Node


@onready var try_again_button: Button = %TryAgainButton
@onready var quit_button: Button = %QuitButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	try_again_button.connect("pressed", on_try_again_pressed)
	quit_button.connect("pressed", on_quit_pressed)
	

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		start_game()
	elif event.is_action_pressed("ui_cancel"):
		quit_game()


func start_game() -> void:
	get_tree().change_scene_to_file("res://scenes/main/main.tscn")
	
	
func quit_game() -> void:
	get_tree().change_scene_to_file("res://scenes/menu/menu.tscn")


func on_try_again_pressed() -> void:
	start_game()

func on_quit_pressed() -> void:
	quit_game()
