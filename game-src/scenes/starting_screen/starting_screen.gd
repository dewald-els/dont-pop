extends CanvasLayer

@onready var ready_timer: Timer = %ReadyTimer
@onready var countdown_label: Label = %CountdownLabel

var time_start: int = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ready_timer.timeout.connect(_on_ready_timeout)
	countdown_label.text = str(time_start)
	get_tree().paused = true

func _process(delta: float) -> void:
	countdown_label.text = str(ceil(ready_timer.time_left))

func _on_ready_timeout() -> void:
	get_tree().paused = false
	queue_free()
