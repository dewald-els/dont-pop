class_name Spawner extends Node2D

@onready var viewport_height: int = ProjectSettings.get_setting("display/window/size/viewport_height")
@onready var viewport_width: int = ProjectSettings.get_setting("display/window/size/viewport_width")
@onready var spawn_timer: Timer = %SpawnTimer

@export var spawn_distance: int
@export var items: Array[PackedScene]

var duration: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_timer.connect("timeout", on_spawn_timeout)
	
	
func _process(delta: float) -> void:
	duration += delta
	print(roundf(duration))
	
func randomize_spawn_point() -> Vector2:
	var spawn_point: Vector2 = Vector2.ZERO

	randomize()
	var side = randi_range(1, 4)

	if side == 1: # top edge
		spawn_point = Vector2(randf_range(0, get_viewport_rect().size.x),0)
	if side == 3: # bottom edge
		spawn_point = Vector2(randf_range(0, get_viewport_rect().size.x), get_viewport_rect().size.y)
	if side == 2: # right edge
		spawn_point = Vector2(get_viewport_rect().size.x, randf_range(0, get_viewport_rect().size.y))
	if side == 4: # left edge
		spawn_point = Vector2(0, randf_range(0, get_viewport_rect().size.y))

	return spawn_point
	
	

func on_spawn_timeout() -> void: 
	if items and items.size() > 0:
		var location: Vector2 = randomize_spawn_point()
		var random_item_scene = items[randi() % items.size()]
		var item: BaseHazard = random_item_scene.instantiate()
		item.speed = 325.0
		item.global_position = location
		get_parent().add_child(item)
		spawn_timer.wait_time = randf_range(0.40, 1.25)
		spawn_timer.start()
	
	
