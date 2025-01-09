class_name UpgradeManager
extends Node


signal upgrade_collected(upgrade: UpgradeResource)


func add_upgrade(upgrade: UpgradeResource) -> void:
	upgrade_collected.emit(upgrade)
