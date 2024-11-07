class_name ScoreManager
extends CanvasLayer

@export var experience_manager: ExperienceManager

@onready var score_label: Label = %ScoreLabel
@onready var score_timer: Timer = %ScoreTimer
@onready var level_label: Label = %LevelLabel


var score: int = 0


func _ready() -> void:
	score_timer.timeout.connect(on_score_timer_timeout)
	ScoreKeeper.score = 0
	
	if experience_manager:
		experience_manager.on_level_up.connect(_on_level_up)


func on_score_timer_timeout() -> void:
	score += 1
	ScoreKeeper.score = score
	score_label.text = "Score: " + str(score)
	experience_manager.increment_experience(0.25)

func _on_level_up(level: int) -> void:
	level_label.text = "Level " + str(level)
