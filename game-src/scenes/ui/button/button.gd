class_name GameButton
extends Button

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

#var click_stream: AudioStream

signal did_press

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pressed.connect(on_pressed)


func on_pressed() -> void:
	audio_stream_player_2d.play()
	await get_tree().create_timer(0.15).timeout
	did_press.emit()
	
