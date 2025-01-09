class_name Player extends CharacterBody2D

# Components
@onready var health_component: HealthComponent = %HealthComponent
@onready var velocity_component: VelocityComponent = %VelocityComponent

@onready var animated_sprite: AnimatedSprite2D = %AnimatedSprite

# Dependencies
@export_group("Dependencies")
@export var player_death: PackedScene

@export_group("Managers")
@export var experience_manager: ExperienceManager
@export var upgrade_manager: UpgradeManager

var base_speed: float = 0.0
var is_dead: bool = false

func _ready() -> void:
	SignalBus.connect("player_popped", on_player_popped)
	base_speed = velocity_component.max_speed
	
	if health_component:
		health_component.health_depleated.connect(on_player_popped)
	
	if upgrade_manager: 
		upgrade_manager.upgrade_collected.connect(_on_upgrade_collected)
	

func _physics_process(_delta: float) -> void:
	var movement_vector: Vector2 = get_input_vector()
	var direction: Vector2 = movement_vector.normalized()
	
	velocity_component.accelerate(direction)
	velocity_component.move(self)

	play_animation(direction)
	face_movement_direction(direction.x)
	
	
func get_input_vector() -> Vector2:
	var horizontal = Input.get_axis("player_left", "player_right")
	var vertical = Input.get_axis("player_up", "player_down")
	
	return Vector2(
		horizontal, 
		vertical
	)
	

func face_movement_direction(direction: float) -> void:
	if direction > 0.0:
		scale.x = scale.y * 1
	elif direction < 0.0:
		scale.x = scale.y * -1


func play_animation(direction: Vector2) -> void:
	if direction != Vector2.ZERO:
		animated_sprite.play("move")
	else:
		animated_sprite.play("idle")
		
			
	
func on_player_popped() -> void:
	var death: PlayerDeath = player_death.instantiate()
	get_tree().root.add_child(death)
	death.global_position = global_position
	queue_free()
	
func _on_upgrade_collected(upgrade: UpgradeResource) -> void:
	upgrade.apply(self)
