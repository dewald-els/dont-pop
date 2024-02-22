class_name Cloud extends Sprite2D


var movement_speed: Vector2 = Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position += movement_speed * delta

	if global_position.y + 32 < 0:
		var random_x = randi_range(16, 270)
		global_position.x = random_x
		global_position.y = 200
