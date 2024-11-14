extends CanvasLayer

@onready var ready_timer: Timer = %ReadyTimer
@onready var countdown_label: Label = %CountdownLabel
@onready var countdown_stream_player_2d: AudioStreamPlayer2D = %CountdownStreamPlayer2D

var time_start: int = 3
var time_left: int = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ready_timer.timeout.connect(_on_ready_timeout)
	countdown_label.text = str(time_start)
	get_tree().paused = true
	
	
func _on_timeout_finished() -> void:
	get_tree().paused = false
	queue_free()

func _on_ready_timeout() -> void:
	time_left -= 1
	countdown_label.text = str(ceil(time_left))
	countdown_stream_player_2d.play()
	if time_left == 0:
		Callable(_on_timeout_finished).call_deferred()
	
