class_name HeartSpawner
extends Node2D


@onready var spawn_timer: Timer = %SpawnTimer
@onready var debug_label: Label = %DebugLabel


@export_group("Spawn properties")
@export var enable_debug: bool = false
## Minimum spawn time in seconds
@export var minimum_spawn_time: float = 0.0
## Maximum spawn time in seconds
@export var maximum_spawn_time: float = 100.0
@export var position_offset: int = 48

@export_group("Dependencies")
@export var heart_pickup_scene: PackedScene
@export var player: Player

var _can_spawn: bool = false

var pickups_container: Node


func _ready() -> void:
	if not enable_debug:
		debug_label.visible = false
		
	if player and player.health_component:
		player.health_component.health_lost.connect(_on_health_lost)
		player.health_component.health_increased.connect(_on_health_increased)
		player.health_component.health_depleated.connect(_on_health_depleted)
		_can_spawn = _can_spawner_activate()
		debug_label.text =  "Can spawn: " + str(_can_spawn)
		if _can_spawn:
			start_spawner()
	
	spawn_timer.timeout.connect(_on_spawn_timeout)
	pickups_container = get_tree().get_first_node_in_group("pickups_container")


func _can_spawner_activate() -> bool:
	return player.health_component.health != player.health_component.max_health
	
	
func _get_random_spawn_location() -> Vector2:
	var viewport_x = get_viewport_rect().size.x - position_offset
	var x: int = randi_range(position_offset, viewport_x)
	print("RandomX: ", str(x))
	return Vector2(x, get_viewport_rect().size.y + position_offset)

func start_spawner() -> void:
	if spawn_timer.is_stopped():
		var random_spawn_time: float = randf_range(minimum_spawn_time, maximum_spawn_time)
		debug_label.text = "can spawn: " + str(_can_spawn) + " - spawn time: " + str(random_spawn_time)
		spawn_timer.wait_time = random_spawn_time
		spawn_timer.start()

func _on_spawn_timeout() -> void:
	var heart_pickup: HeartPickup = heart_pickup_scene.instantiate()
	heart_pickup.collected.connect(func(health_amount:int):
		player.health_component.add_health(health_amount)
	)
	var location = _get_random_spawn_location()
	pickups_container.add_child(heart_pickup)
	heart_pickup.global_position = location

func _on_health_lost(_health: int) -> void:
	_can_spawn = true
	start_spawner()
	
func _on_health_depleted() -> void:
	_can_spawn = false
	if not spawn_timer.is_stopped():
		spawn_timer.stop()

func _on_health_increased(_health: int) -> void:
	if _can_spawner_activate():
		_can_spawn = true
	else:
		_can_spawn = false
