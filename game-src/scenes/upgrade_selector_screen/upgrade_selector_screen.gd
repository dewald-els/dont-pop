class_name UpgradeSelectorScreen
extends CanvasLayer

signal upgrade_selected

@export var upgrade_panel_scene: PackedScene

@onready var upgrades_grid_container: VBoxContainer = %UpgradesGridContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().paused = true
	
func _on_test_pressed() -> void:
	get_tree().paused = false
	upgrade_selected.emit("speed")


func set_available_upgrades(upgrades: Array[PlayerAbilityUpgrade]) -> void:
	var delay: float = 0.0
	
	for upgrade in upgrades:
		var picker_instance: PlayerUpgradePanel = upgrade_panel_scene.instantiate()
		upgrades_grid_container.add_child(picker_instance)
		picker_instance.set_upgrade(upgrade)
		#picker_instance.play_in(delay)
		#picker_instance.selected.connect(_handle_upgrade_selected.bind(upgrade))
		delay += 0.2
