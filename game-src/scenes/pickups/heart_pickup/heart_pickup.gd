class_name HeartPickup
extends Node2D

signal collected(health_amount: int)

@onready var lifetime_timer: Timer = %LifetimeTimer
@onready var heart_pickup_sprite: Sprite2D = %HeartPickupSprite
@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var pickup_area_collision: CollisionShape2D = %PickupAreaCollision

@export_group("Movement properties")
@export var speed: float = 150.0
@export var amplitude: float = 3.5
@export var frequency: float = 5.5

@export_group("Health properties")
@export var health_amount: int = 1

var swing_time: float 
var scale_time: float

var stop_moving: bool = false

@onready var pickup_area_2d: Area2D = %PickupArea2D

func _ready() -> void:
	pickup_area_2d.body_entered.connect(_on_body_entered)
	lifetime_timer.timeout.connect(_on_lifetime_timeout)

func _process(delta: float) -> void:
	if stop_moving:
		return
		
	swing_time += delta * frequency
	var sin_wave = sin(swing_time) * amplitude * delta
	var scale_wave = cos(sin_wave)
	heart_pickup_sprite.scale = Vector2(scale_wave, scale_wave)
	global_position.x += sin(swing_time) * amplitude * delta
	global_position.y -= speed * delta
	

func _on_body_entered(body: Node2D) -> void:
	if "Player" in body.name:
		collected.emit(health_amount)
		stop_moving = true
		pickup_area_collision.disabled = true
		animation_player.play("collected")

func _on_lifetime_timeout() -> void:
	queue_free()
