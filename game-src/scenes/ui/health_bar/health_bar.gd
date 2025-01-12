class_name HealthBar
extends CanvasLayer

@onready var hearts_container_h_box: HBoxContainer = %HeartsContainerHBox

@export var health_component: HealthComponent
@export var heart_texture: Texture

var current_hearts: Array[TextureRect] = []

func _ready() -> void:
	if not health_component:
		return
		
	_create_health_hearts(health_component.health)
	health_component.health_lost.connect(_on_health_lost)
	health_component.health_increased.connect(_on_health_increased)
	
	
func _create_health_hearts(health: int) -> void:
	for i in health:
		var heart: TextureRect = TextureRect.new()
		heart.texture = heart_texture
		current_hearts.append(heart)
		hearts_container_h_box.add_child(heart)

func _on_health_increased(new_health: int) -> void:
	current_hearts.clear()
	
	for child in hearts_container_h_box.get_children(): 
		child.queue_free()
	
	_create_health_hearts(new_health)

func _on_health_lost(health: int) -> void:
	if health == 0:
		return
	
	for i in current_hearts.size():
		if i >= health:
			hearts_container_h_box.remove_child(current_hearts[i])
			
			
	current_hearts = current_hearts.slice(0, health)
