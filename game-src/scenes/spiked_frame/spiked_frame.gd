class_name SpikeFrame
extends Node2D


@onready var top_area: Area2D = %TopArea
@onready var left_area: Area2D = %LeftArea
@onready var bottom_area: Area2D = %BottomArea
@onready var right_area: Area2D = %RightArea


func _ready() -> void:
	top_area.body_entered.connect(_on_body_entered)
	left_area.body_entered.connect(_on_body_entered)
	bottom_area.body_entered.connect(_on_body_entered)
	right_area.body_entered.connect(_on_body_entered)
	
func _on_body_entered(body: Node2D) -> void:
	if "Player" in body.name:
		SignalBus.player_popped.emit()
