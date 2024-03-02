extends Button

@onready var sfx_click: AudioStreamPlayer2D = %SfxClick

var click_stream: AudioStream

signal did_press

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("pressed", on_pressed)
	click_stream = load("res://scenes/ui/button/sounds/click.wav")


func on_pressed() -> void:
	SfxPlayer.play_sfx(click_stream, "UI_SFX")
	emit_signal("did_press")
	
