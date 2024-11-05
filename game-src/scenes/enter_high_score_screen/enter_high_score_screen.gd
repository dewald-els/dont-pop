class_name EnterHighScoreScreen
extends CanvasLayer

@onready var notice_text: Label = %NoticeText
@onready var high_score_name_spinner: HighScoreNameSpinner = %HighScoreNameSpinner

var saving: bool = false

func _ready() -> void:
	high_score_name_spinner.confirm_name.connect(_on_name_confirm)
	HighScoreManager.save_completed.connect(_on_score_saved)
	
	
func _on_score_saved() -> void:
	get_tree().change_scene_to_file("res://scenes/menu/menu.tscn") 

func _on_name_confirm(confirmed_name: String) -> void:
	if saving:
		return
		
	saving = true
	notice_text.text = "Saving..."
	var score = ScoreKeeper.score
	HighScoreManager.add_high_score(confirmed_name, score)
	
