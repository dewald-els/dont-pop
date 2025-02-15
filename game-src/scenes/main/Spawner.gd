class_name Spawner extends Node2D

const MIN_SPAWN_INTERVAL: float = 0.75

@onready var viewport_height: int = ProjectSettings.get_setting("display/window/size/viewport_height")
@onready var viewport_width: int = ProjectSettings.get_setting("display/window/size/viewport_width")
@onready var spawn_timer: Timer = %SpawnTimer
@onready var spawn_debug_label: GameLabel = %SpawnDebugLabel


@export_group("Spawner config")
@export var spawn_interval: float = 2.5
@export var spawn_distance: int
@export var enable_debugging: bool = false
@export_group("Hazard items")
@export var items: Array[PackedScene]
@export_group("Managers")
@export var experience_manager: ExperienceManager

var active_item: BaseHazard
var hazards_pool: Array[BaseHazard] = []


func increase_pool( max: int = 100) -> void:
	if hazards_pool.size() == 100:
		return
		
	# Duplicate current pool
	var cloned_items: Array[PackedScene] = items.duplicate()
	for item in cloned_items:
		items.append(item)
		
	# Add cloned items to pool
	for item in items:
		var instance = item.instantiate() as BaseHazard
		instance.global_position = Vector2(-100, -100)
		hazards_pool.append(instance)
		get_parent().add_child.call_deferred(instance)
		
	# Slice out if too many items were added
	if hazards_pool.size() > max:
		hazards_pool = hazards_pool.slice(0, max)
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not enable_debugging:
		spawn_debug_label.visible = false
		
	if experience_manager:
		experience_manager.on_level_up.connect(_on_player_level_up)
		
	increase_pool()
		
	spawn_timer.wait_time = spawn_interval
	spawn_timer.connect("timeout", on_spawn_timeout)
	spawn_timer.start()
	spawn_debug_label.text = str(spawn_interval)

	
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
	
	
func _calculate_new_spawn_interval(new_player_level: int) -> float:
	if spawn_interval > MIN_SPAWN_INTERVAL:
		var new_spawn_interval: float = spawn_interval - (new_player_level * 0.10)
		return max(
			MIN_SPAWN_INTERVAL,
			new_spawn_interval
		)
	else:
		return spawn_interval


func on_spawn_timeout() -> void: 
	if items and items.size() > 0:
		var location: Vector2 = randomize_spawn_point()
		var item: BaseHazard = null
		
		while(item == null):
			item = hazards_pool.pick_random() as BaseHazard
			if not item.is_sleeping:
				item = null
				
		item.global_position = location
		item.wake_up()
		spawn_timer.wait_time = spawn_interval
		spawn_timer.start()

	
func _on_player_level_up(level: int) -> void:
	increase_pool()
	spawn_interval = _calculate_new_spawn_interval(level)
	spawn_timer.stop()
	spawn_timer.wait_time = spawn_interval
	spawn_timer.start()
	spawn_debug_label.text = "spawn timeout: " + str(spawn_interval) + "\nHazard pool: " + str(hazards_pool.size())
	
