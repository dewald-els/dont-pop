extends Node2D


@export var cloud_sprite: PackedScene
@export var number_of_clouds: int = 2

var clouds: Array[Sprite2D]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	generate_clouds()


func generate_clouds() -> void:
	for i in number_of_clouds:
		var sprite = cloud_sprite.instantiate() as Cloud
		sprite.modulate.a = randf_range(0.35, 1)
		var sprite_scale: float = randf_range(0.5, 1.25)
		sprite.scale = Vector2(sprite_scale, sprite_scale)
		
		if sprite_scale > 1.0:
			sprite.z_index = 3
		else: 
			sprite.z_index = 1

		var random_x:int = randi_range(16, 270)
	
		var random_y:int = randi_range(180, 250)
		sprite.global_position = Vector2(random_x, random_y)
		
		randomize()
		var random_speed: float = randf_range(1.25, 15)
		sprite.movement_speed = Vector2(0, -random_speed)
		add_child(sprite)
		
