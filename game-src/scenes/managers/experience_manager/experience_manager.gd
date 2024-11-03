class_name ExperienceManager
extends Node


const TARGET_EXPERIENCE_GROWTH: float = 5.0


signal on_experience_changed(current_experience: float, target_experience: float)
signal on_level_up(level: int)


var current_experience: float = 0.0
var current_level: int = 1
var target_experience: float = 5.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func increment_experience(experience_gained: float) -> void:
	current_experience = min(
		current_experience + experience_gained,
		target_experience
	)
	
	on_experience_changed.emit(current_experience, target_experience)
	
	if current_experience == target_experience:
		current_level += 1
		target_experience += TARGET_EXPERIENCE_GROWTH
		current_experience = 0
		on_experience_changed.emit(current_experience, target_experience)
		on_level_up.emit(current_level)
