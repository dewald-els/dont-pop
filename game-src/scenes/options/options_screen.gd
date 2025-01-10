class_name OptionsScreen
extends CanvasLayer

@onready var back_button: GameButton = %BackButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	back_button.did_press.connect(_on_back_pressed)


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu/menu.tscn")
