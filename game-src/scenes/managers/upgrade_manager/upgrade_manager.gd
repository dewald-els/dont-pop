class_name UpgradeManager
extends Node


@export var experience_manager: ExperienceManager


var current_upgrades: Dictionary = {}

func _ready() -> void:
	if experience_manager:
		experience_manager.on_level_up.connect(_on_player_level_up)

func apply_upgrade() -> void:
	pass

func get_random_upgrades(_number_of_upgrades: int = 3) -> Array:
	return []


func _on_player_level_up(_new_level: int) -> void:
	pass
