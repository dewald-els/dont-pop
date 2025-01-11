class_name BaseHazard
extends CharacterBody2D

signal on_sleep(item: BaseHazard)
@onready var hitbox: Area2D = %Hitbox
@onready var sfx_throw: AudioStreamPlayer2D = %SfxThrow
@onready var lifespan_timer: Timer = %LifespanTimer

# Components
@onready var velocity_component: VelocityComponent = %VelocityComponent


@export_group("Stats")
@export var damage: float = 1.0
@export var hazard_properties: HazardPropertiesResource
@export var lifespan: float = 6.0

var _target_position: Vector2
var _direction: Vector2
var is_sleeping: bool = true

func _ready() -> void:
	var target = get_tree().get_first_node_in_group("player") as Player
	
	if not target:
		return
	
	if hazard_properties:
		velocity_component.acceleration = hazard_properties.base_speed
		damage = hazard_properties.base_damage
	
	hitbox.connect("body_entered", _on_body_entered)
	lifespan_timer.wait_time = lifespan
	lifespan_timer.timeout.connect(_on_destroy)
		
	
func _physics_process(_delta: float) -> void:
	if is_sleeping:
		return
		
	rotation += hazard_properties.rotation_speed
	velocity_component.move(self)
	
	
func _calculate_velocity() -> Vector2:
	_target_position = PlayerTracker.get_last_position()
	_direction = _target_position - global_position
	var target_velocity = _direction.normalized() * hazard_properties.base_speed
	return target_velocity
	

func _on_destroy() -> void:
	sleep()
	
func sleep() -> void:
	is_sleeping = true
	visible = false
	
func wake_up() -> void:
	velocity_component.velocity = _calculate_velocity()
	sfx_throw.play()
	visible = true
	is_sleeping = false
	lifespan_timer.start()
	
func _on_body_entered(body: Node2D) -> void:
	if "Player" in body.name:
		var hc: HealthComponent = body.health_component
		hc.remove_health(damage)
