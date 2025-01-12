class_name HealthComponent
extends Node

signal health_depleated
signal health_lost(health: int)
signal health_increased(health: int)


@onready var hurt_sound_player: AudioStreamPlayer2D = %HurtSoundPlayer


@export var health: int
@export var max_health: int
@export var hurt_sound: AudioStream

func _ready() -> void:
	if hurt_sound:
		hurt_sound_player.stream = hurt_sound

func add_max_health(amount: int) -> void:
	max_health += amount
	health_increased.emit(health)


func add_health(amount: int) -> void:
	
	if amount == 0:
		return 
	
	health = clamp(health, health + amount, max_health);
	health_increased.emit(health)

func remove_health(amount: int) -> void:
	health = clamp(health, 0, health - amount)
	
	
	if health == 0:
		health_depleated.emit()
	else:
		if hurt_sound and not hurt_sound_player.is_playing():
			hurt_sound_player.play()
		health_lost.emit(health)
