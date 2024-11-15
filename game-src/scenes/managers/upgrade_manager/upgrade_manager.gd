class_name UpgradeManager
extends Node


@export var experience_manager: ExperienceManager
@export var upgrade_scene: PackedScene

var current_upgrades: Dictionary = {}

func _ready() -> void:
	if experience_manager:
		experience_manager.on_level_up.connect(_on_player_level_up)

func apply_upgrade() -> void:
	pass

func get_random_upgrades(_number_of_upgrades: int = 3) -> Array:
	return []


func _on_player_level_up(_new_level: int) -> void:
	if upgrade_scene:
		var upgrade_instance = upgrade_scene.instantiate()
		get_tree().root.add_child(upgrade_instance)
		upgrade_instance.upgrade_selected.connect(func(upgrade):
			_on_upgrade_selected(upgrade)
			upgrade_instance.queue_free()
		)

func _on_upgrade_selected(upgrade) -> void:
	pass
