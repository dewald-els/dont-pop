class_name BaseHazard
extends CharacterBody2D

const ROTATION_SPEED: float = 5.0


@onready var hazard_area: Area2D = $Area2D
@onready var sfx_throw: AudioStreamPlayer2D = %SfxThrow


var target_position: Vector2
var speed: float
var direction: Vector2

func _ready() -> void:
	var target = get_tree().get_first_node_in_group("player") as Player
	
	if not target:
		return
		
	hazard_area.connect("body_entered", on_body_entered)
		
	target_position = PlayerTracker.get_last_position()
	direction = target_position - global_position
	
	get_tree().create_timer(5.0).connect("timeout", on_destroy)
	
	sfx_throw.play()

		
func _physics_process(delta: float) -> void:
	rotation += ROTATION_SPEED * delta
	velocity += direction.normalized() * speed * delta
	move_and_slide()
	


func on_destroy() -> void:
	print("Destory item")
	queue_free()
	
func on_body_entered(body: Node2D) -> void:
	if "Player" in body.name:
		SignalBus.emit_signal("player_popped")
	
