class_name UpgradeManager
extends Node


@export var experience_manager: ExperienceManager
@export var upgrade_scene: PackedScene

var number_of_upgrades_to_show: int = 1
var upgrade_pool: WeightedTable = WeightedTable.new()
var current_upgrades: Dictionary = {}

var _upgrade_player_dash: PlayerAbilityUpgrade = preload("res://scenes/player/player_upgrades/player_dash.tres")
var _upgrade_player_health: PlayerAbilityUpgrade = preload("res://scenes/player/player_upgrades/player_health.tres")
var _upgrade_player_additional_health: PlayerAbilityUpgrade = preload("res://scenes/player/player_upgrades/player_health.tres")
var _upgrade_player_speed: PlayerAbilityUpgrade = preload("res://scenes/player/player_upgrades/player_speed.tres")
var _upgrade_player_shield: PlayerAbilityUpgrade = preload("res://scenes/player/player_upgrades/player_shield.tres")

func _ready() -> void:
	if experience_manager:
		experience_manager.on_level_up.connect(_on_player_level_up)
		
	upgrade_pool.add_item(_upgrade_player_dash, 10)
	upgrade_pool.add_item(_upgrade_player_health, 20)
	upgrade_pool.add_item(_upgrade_player_speed, 30)
	upgrade_pool.add_item(_upgrade_player_shield, 10)


func get_random_upgrades(_number_of_upgrades: int = 3) -> Array:
	# First time, only show speed boost
	if number_of_upgrades_to_show == 1:
		number_of_upgrades_to_show = 3
		return [_upgrade_player_speed]
	
	var chosen_upgrades: Array[PlayerAbilityUpgrade] = []
	
	for i in number_of_upgrades_to_show:
		if upgrade_pool.items.size() == chosen_upgrades.size():
			break
		
		var chosen_upgrade: PlayerAbilityUpgrade = upgrade_pool.pick_item(chosen_upgrades)
		chosen_upgrades.append(chosen_upgrade)
		
	return chosen_upgrades

func _apply_upgrade(upgrade: PlayerAbilityUpgrade) -> void:
	var has_upgrade: bool = current_upgrades.has(upgrade.id)
	
	if not has_upgrade:
		current_upgrades[upgrade.id] = {
			"upgrade": upgrade,
			"quantity": 1
		}
	else:
		current_upgrades[upgrade.id]["quantity"] += 1
		
	if upgrade.max_quantity > 0:
		var current_quantity: int = current_upgrades[upgrade.id]["quantity"]
		if current_quantity == upgrade.max_quantity:
			upgrade_pool.remove_item(upgrade)
	
	SignalBus.player_ability_upgrade_added.emit(upgrade, current_upgrades)
	
func _update_upgrade_pool(upgrade: PlayerAbilityUpgrade) -> void:
	if upgrade.id == _upgrade_player_additional_health.id:
		upgrade_pool.add_item(_upgrade_player_additional_health, 10)

func _on_player_level_up(_new_level: int) -> void:
	if not upgrade_scene:
		return 
		
	var upgrades = get_random_upgrades()
	
	if upgrades.size() == 0:
		return
		
	var upgrade_instance = upgrade_scene.instantiate()
	get_tree().root.add_child(upgrade_instance)
	upgrade_instance.set_available_upgrades(upgrades)
	upgrade_instance.upgrade_selected.connect(func(upgrade):
		_on_upgrade_selected(upgrade)
		upgrade_instance.queue_free()
	)

func _on_upgrade_selected(upgrade) -> void:
	_apply_upgrade(upgrade)
