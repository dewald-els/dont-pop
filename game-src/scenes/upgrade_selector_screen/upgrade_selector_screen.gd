class_name UpgradeSelectorScreen
extends CanvasLayer

signal upgrade_selected

@onready var test_button: Button = %TestButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	test_button.pressed.connect(_on_test_pressed)
	get_tree().paused = true
	
func _on_test_pressed() -> void:
	get_tree().paused = false
	upgrade_selected.emit("speed")
