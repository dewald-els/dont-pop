class_name MaxHealthUpgradeResource
extends UpgradeResource

@export var amount_to_add_max_health: int
@export var amount_to_add_health: int


func apply(owner: Node) -> void:
	if owner.health_component:
		print("found health component for ", owner.name)
		var health_component: HealthComponent = owner.health_component
		health_component.add_max_health(amount_to_add_max_health)
		health_component.add_health(amount_to_add_health)
	else:
		print("did not find a health component on ", owner.name)
