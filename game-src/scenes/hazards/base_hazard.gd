class_name BaseHazard
extends CharacterBody2D

@export var hazard_properties: HazardPropertiesResource

@onready var hazard_area: Area2D = $Area2D
@onready var sfx_throw: AudioStreamPlayer2D = %SfxThrow

var _target_position: Vector2
var _direction: Vector2

func _ready() -> void:
	var target = get_tree().get_first_node_in_group("player") as Player
	
	if not target:
		return
	
	hazard_area.connect("body_entered", _on_body_entered)	
	velocity = _calculate_velocity()
	sfx_throw.play()
	
	get_tree().create_timer(5.0).connect("timeout", _on_destroy)
		
	
func _physics_process(delta: float) -> void:
	rotation += hazard_properties.rotation_speed
	move_and_slide()

	
func increase_base_speed(speed_multiplier: float) -> void:
	hazard_properties.base_speed + (hazard_properties.base_speed * speed_multiplier)

func increase_base_damage(damage_multiplier: float) -> void:
	hazard_properties.base_damage + (hazard_properties.base_damage * damage_multiplier)
	
func _calculate_velocity() -> Vector2:
	_target_position = PlayerTracker.get_last_position()
	_direction = _target_position - global_position
	print(self.name + " direction to player: ", _direction.normalized())
	var target_velocity = _direction.normalized() * hazard_properties.base_speed
	print(self.name + " target velocity: ", target_velocity)
	return target_velocity
	

func _on_destroy() -> void:
	queue_free()
	
	
func _on_body_entered(body: Node2D) -> void:
	if "Player" in body.name:
		SignalBus.emit_signal("player_popped")
	
