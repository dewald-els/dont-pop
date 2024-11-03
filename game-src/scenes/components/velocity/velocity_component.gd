class_name VelocityComponent
extends Node


@export var max_speed: int = 40
@export var acceleration: float = 5.0


var velocity: Vector2 = Vector2.ZERO

func get_direction_to(subject: Node2D) -> Vector2:
	var owner_node: Node2D = owner as Node2D
	
	if !owner_node:
		return Vector2.ZERO
	
	if !subject:
		return Vector2.ZERO
		
	var direction: Vector2 = (subject.global_position - owner_node.global_position).normalized()
	
	return direction

func accelerate(direction: Vector2) -> void:
	var target_velocity: Vector2 = direction * max_speed
	velocity = velocity.lerp(target_velocity, 1 - exp(-acceleration * get_process_delta_time()))


func stop() -> void:
	accelerate(Vector2.ZERO)
	

func move(character_body: CharacterBody2D) -> void:
	character_body.velocity = velocity
	character_body.move_and_slide()
	velocity = character_body.velocity
