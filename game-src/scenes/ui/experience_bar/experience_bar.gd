class_name PlayerExperienceBar
extends CanvasLayer

@export var experience_manager: ExperienceManager
@onready var progress_bar: ProgressBar = %ProgressBar


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	progress_bar.value = 0.0
	
	if !experience_manager:
		return
		
	
	experience_manager.on_experience_changed.connect(_on_experience_changed)
	experience_manager.on_level_up.connect(_on_level_up)

func _on_experience_changed(current_xp: float, target_xp: float) -> void:
	var percentage: float = current_xp / target_xp
	progress_bar.value = percentage

func _on_level_up(_level: int) -> void:
	pass
