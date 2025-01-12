class_name MainGame
extends Node2D

@export_group("Managers")
@export var experience_manager: ExperienceManager

@export_group("Scenes")
@export var wave_ended_screen_scene: PackedScene
@export var heart_spawner_scene: PackedScene

@export_group("Entities")
@export var player: Player


@onready var managers: Node = %Managers


func _ready() -> void:
	PlayerTracker.clear()
	MusicPlayer.play_game_song()
	
	if experience_manager:
		experience_manager.on_level_up.connect(_on_level_up)
		

func _on_level_up(level: int) -> void:
	var wave_ended_screen: WaveEndedScreen = wave_ended_screen_scene.instantiate()
	get_tree().root.add_child(wave_ended_screen)
	
	if level == 2:
		print("creating heart spawner")
		var heart_spawner: HeartSpawner = heart_spawner_scene.instantiate()
		heart_spawner.player = player
		managers.add_child(heart_spawner)
