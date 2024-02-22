extends Node2D


@onready var score_label: Label = %ScoreLabel
@onready var score_timer: Timer = %ScoreTimer


var score: int = 0


func _ready() -> void:
	score_timer.connect("timeout", on_score_timer_timeout)


func on_score_timer_timeout() -> void:
	score += 1
	score_label.text = "Score: " + str(score)
