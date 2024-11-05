extends Node

@onready var save_scores_request: HTTPRequest = %SaveScoresRequest
@onready var get_scores_request: HTTPRequest = %GetScoresRequest

const SAVE_DATA_PATH: String = "user://dontpop_leaderboar.save"
const API_URL: String = "https://dontpop.dewaldels.com/"
const API_KEY: String = "Arkkm4adT3uqoPJsi7jMY4SO"

var high_scores: Array[Dictionary] = []

signal save_completed

func _ready() -> void:
	get_scores_request.request_completed.connect(_on_get_scores_complete)
	save_scores_request.request_completed.connect(_on_save_scores_complete)
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
	var headers = _get_request_headers()
	get_scores_request.request(
		API_URL + "get_scores.php", 
		headers, 
		HTTPClient.Method.METHOD_GET
	)

func _on_get_scores_complete(_result, response_code, _headers, body):
	if response_code == HTTPClient.ResponseCode.RESPONSE_OK:
		var data = body.get_string_from_utf8()
		var json = JSON.parse_string(data) as Array[Dictionary]
		
		for score in json:
			high_scores.append({
				"name": score["name"],
				"score": int(score["score"])
			})
	else:
		high_scores = []

func _on_save_scores_complete(_result, _response_code, _headers, _body) -> void:
	save_completed.emit()
	
func _get_request_headers() -> Array[String]:
	return [
		"Content-Type: application/json",
		"x-api-key: " + API_KEY
	]

func _save() -> void:
	high_scores.sort_custom(sort_decsending)
	var json = JSON.stringify({
		"scores": high_scores
	})
	var headers = _get_request_headers()
	save_scores_request.request(API_URL + "update_scores.php", headers, HTTPClient.METHOD_POST, json)

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
	
