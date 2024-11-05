class_name LeaderboardScreen
extends CanvasLayer

@export var max_scores: int = 3

@onready var high_scores_container: VBoxContainer = %HighScoresContainer
@onready var back_button: GameButton = %BackButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var high_scores = HighScoreManager.high_scores
	
	back_button.did_press.connect(_on_back_pressed)
	
	if not high_scores or high_scores.size() == 0:
		var label = get_label_with_theme("No high scores...")
		high_scores_container.add_child(label)
	else:
		var display_scores = high_scores.slice(0, max_scores)
		for score in display_scores:
			var score_text: String = score["name"] + " - " + str(score["score"])
			var label = get_label_with_theme(score_text)
			high_scores_container.add_child(label)

func get_label_with_theme(score: String) -> Label:
	var label: Label = Label.new()
	label.text = score
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.theme = load("res://resources/theme.tres")
	return label

func _load_menu() -> void:
	get_tree().change_scene_to_file("res://scenes/menu/menu.tscn")

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		_load_menu()

func _on_back_pressed() -> void:
	_load_menu()
