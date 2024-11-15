class_name PlayerUpgradePanel
extends PanelContainer

@onready var upgrade_title_label: GameLabel = %UpgradeTitleLabel
@onready var upgrade_description_label: GameLabel = %UpgradeDescriptionLabel

var _upgrade: PlayerAbilityUpgrade


func set_upgrade(upgrade: PlayerAbilityUpgrade) -> void:
	_upgrade = upgrade
	
	upgrade_title_label.text = upgrade.name
	upgrade_description_label.text = upgrade.description
