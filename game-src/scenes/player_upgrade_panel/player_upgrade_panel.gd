class_name PlayerUpgradePanel
extends Button

signal upgrade_selected(upgrade: PlayerAbilityUpgrade)

@onready var upgrade_title_label: GameLabel = %UpgradeTitleLabel
@onready var upgrade_description_label: GameLabel = %UpgradeDescriptionLabel

var _upgrade: PlayerAbilityUpgrade

func _ready() -> void:
	pressed.connect(_handle_pressed)

func set_upgrade(upgrade: PlayerAbilityUpgrade) -> void:
	_upgrade = upgrade
	
	upgrade_title_label.text = upgrade.name
	upgrade_description_label.text = upgrade.description


func _handle_pressed() -> void:
	upgrade_selected.emit(_upgrade)
