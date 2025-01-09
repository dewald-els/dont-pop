class_name SpeedUpgradeResource
extends UpgradeResource

@export var speed_amount: float 

func apply(owner: Node) -> void:
	if owner.velocity_component:
		var vc: VelocityComponent = owner.velocity_component
		vc.increase_acceleration(speed_amount)
	else:
		print(owner.name + " does not have a velocity component")
