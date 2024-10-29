class_name EnterHighScoreScreen
extends CanvasLayer

@onready var high_score_name_spinner: HighScoreNameSpinner = %HighScoreNameSpinner

func _ready() -> void:
	high_score_name_spinner.confirm_name.connect(_on_name_confirm)
	

func _on_name_confirm(name: String) -> void:
	var score = ScoreKeeper.score
	HighScoreManager.add_high_score(name, score)
	get_tree().change_scene_to_file("res://scenes/menu/menu.tscn")
