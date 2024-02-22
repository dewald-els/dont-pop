extends Node2D


@onready var tracker_timer: Timer = %TrackerTimer


var player: Player
var player_positions: Array[Vector2]


func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	tracker_timer.connect("timeout", on_timeout)
	create_new_interval()
	
	
func create_new_interval() -> void:
	tracker_timer.wait_time = get_random_interval()
	tracker_timer.start()
	
func get_random_interval() -> float:
	randomize()
	return randf_range(0.1, 0.4)


func on_timeout() -> void:
	PlayerTracker.add(player.global_position)
	create_new_interval()
	
	
func get_last_position() -> Vector2:
	return PlayerTracker.get_last_position()
