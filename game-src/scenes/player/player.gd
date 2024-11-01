class_name Player extends CharacterBody2D


@export var move_speed: float
@export var acceleration: float = 3.0
@export var decceleration: float = 1.5


@onready var animated_sprite: AnimatedSprite2D = %AnimatedSprite

var is_dead: bool = false

func _ready() -> void:
	SignalBus.connect("player_popped", on_player_popped)


func _physics_process(_delta: float) -> void:
	var movement_vector: Vector2 = get_input_vector()
	
	if movement_vector == Vector2.ZERO:
		velocity.x = move_toward(velocity.x, 0.0, decceleration)
		velocity.y = move_toward(velocity.y, 0.0, decceleration)
	else:
		velocity.x = move_toward(velocity.x, movement_vector.x * move_speed, acceleration)
		velocity.y = move_toward(velocity.y, movement_vector.y * move_speed, acceleration)
		
	move_and_slide()
	play_animation()
	face_movement_direction(movement_vector.x)
	check_out_of_bounds()
	
	
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
	if velocity != Vector2.ZERO:
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
		
func load_death_screen() -> void:
	get_tree().change_scene_to_file("res://scenes/died/died.tscn")

func load_enter_high_score() -> void:
	get_tree().change_scene_to_file("res://scenes/enter_high_score_screen/enter_high_score_screen.tscn")
	
	
func on_player_popped() -> void:
	
	if HighScoreManager.is_high_score(ScoreKeeper.score):
		Callable(load_enter_high_score).call_deferred()
	else:
		Callable(load_death_screen).call_deferred()
