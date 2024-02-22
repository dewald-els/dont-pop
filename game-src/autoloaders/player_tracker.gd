extends Node

var player_positions: Array[Vector2]

func add(player_position: Vector2) -> void:
	player_positions.push_back(player_position)
	if player_positions.size() > 10:
		player_positions.remove_at(0)

func get_last_position() -> Vector2:
	if player_positions.size() > 0:
		var last_position = player_positions.pop_back()
		return last_position
		
	return Vector2.ZERO
