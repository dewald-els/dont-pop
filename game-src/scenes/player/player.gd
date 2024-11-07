class_name Player extends CharacterBody2D


@onready var velocity_component: VelocityComponent = %VelocityComponent
@onready var animated_sprite: AnimatedSprite2D = %AnimatedSprite

@export var player_death: PackedScene
@export var experience_manager: ExperienceManager

var base_speed: float = 0.0
var is_dead: bool = false

func _ready() -> void:
	SignalBus.connect("player_popped", on_player_popped)
	base_speed = velocity_component.max_speed
	

func _physics_process(_delta: float) -> void:
	var movement_vector: Vector2 = get_input_vector()
	var direction: Vector2 = movement_vector.normalized()
	
	velocity_component.accelerate(direction)
	velocity_component.move(self)

	
	
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


func play_animation() -> void:
	if is_dead:
		animated_sprite.play("pop")
	elif velocity != Vector2.ZERO:
		animated_sprite.play("move")
	else:
		animated_sprite.play("idle")
		
		
func check_out_of_bounds() -> void:
	var viewport = get_viewport_rect().size
	if global_position.x < 12 or \
	   global_position.x > viewport.x - 12 or \
	   global_position.y < 12 or \
	   global_position.y > viewport.y - 8:
		SignalBus.emit_signal("player_popped")
			
	
func on_player_popped() -> void:
	var death: PlayerDeath = player_death.instantiate()
	get_tree().root.add_child(death)
	death.global_position = global_position
	queue_free()
	
