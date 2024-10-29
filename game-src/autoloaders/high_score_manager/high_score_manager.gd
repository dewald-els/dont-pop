extends Node

const SAVE_DATA_PATH: String = "user://dontpop_leaderboar.save"

var high_scores: Array[Dictionary] = []

func _ready() -> void:
	_load_high_scores()
	
func is_high_score(score: int) -> bool:
	
	if high_scores.size() == 0:
		return true
	
	if high_scores.size() < 3:
		return true
	
	var top_3 = high_scores.slice(0, 3)
	
	for high_score in top_3:
		if score >= int(high_score["score"]):
			return true
			
	return false

func _load_high_scores() -> void:
	if not FileAccess.file_exists(SAVE_DATA_PATH):
		return
	
	var current_save_file: FileAccess = FileAccess.open(SAVE_DATA_PATH, FileAccess.READ)
	high_scores = current_save_file.get_var()

func _save() -> void:
	high_scores.sort_custom(sort_decsending)
	var file: FileAccess = FileAccess.open(SAVE_DATA_PATH, FileAccess.WRITE)
	file.store_var(high_scores)

func add_high_score(score_name: String, score: int) -> void:
	if high_scores.size() == 1000:
		high_scores.pop_back()
		
	high_scores.append({
		"name": score_name,
		"score": score
	})
	
	_save()
	
func sort_decsending(a: Dictionary, b: Dictionary) -> bool:
	if int(a["score"]) > int(b["score"]):
		return true
	
	return false
	
