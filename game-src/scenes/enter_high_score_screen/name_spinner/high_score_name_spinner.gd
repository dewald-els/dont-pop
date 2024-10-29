class_name HighScoreNameSpinner
extends MarginContainer

const ALPHABET: Array[String] = [
	"_",
	"A", "B", "C", "D", "E", "F", "G", "H", "I", "J",
	"K", "L", "M", "N", "O", "P", "Q", "R", "S", "T",
	"U", "V", "W", "X", "Y", "Z", 
	"0", "1", "2", "3", "4", "5", "6", "7", "8", "9"
]

@onready var name_label_1: Label = %NameLabel1
@onready var name_label_2: Label = %NameLabel2
@onready var name_label_3: Label = %NameLabel3
@onready var texture_rect_1: TextureRect = %TextureRect1
@onready var texture_rect_2: TextureRect = %TextureRect2
@onready var texture_rect_3: TextureRect = %TextureRect3

var spinners: Array[Dictionary] = []
var spinner_arrows: Array[TextureRect] = []

var active_spinner: int = 0
var active_alphabet: int = 0

signal confirm_name(name: String)

func _ready() -> void:
	spinners.append({
		"index": 0,
		"label": name_label_1
	})
	spinners.append({
		"index": 0,
		"label": name_label_2
	})
	spinners.append({
		"index": 0,
		"label": name_label_3
	})
	
	spinner_arrows.append(texture_rect_1)
	spinner_arrows.append(texture_rect_2)
	spinner_arrows.append(texture_rect_3)
	
	texture_rect_2.modulate.a = 0
	texture_rect_3.modulate.a = 0
	
	
func hide_arrows() -> void:
	texture_rect_1.modulate.a = 0
	texture_rect_2.modulate.a = 0
	texture_rect_3.modulate.a = 0
	
func show_arrow(index: int) -> void:
	hide_arrows()
	spinner_arrows[index].modulate.a = 1.0

func move_left() -> void:
	if active_spinner != 0:
		active_spinner -= 1
	else:
		active_spinner = 2
	active_alphabet = spinners[active_spinner].index
	show_arrow(active_spinner)
	
	
	
func move_right() -> void:
	if active_spinner != 2:
		active_spinner += 1
	else:
		active_spinner = 0
		
	active_alphabet = spinners[active_spinner].index
	show_arrow(active_spinner)
	
	
func next_alphabet() -> void:
	if active_alphabet != ALPHABET.size() - 1:
		active_alphabet += 1
	else:
		active_alphabet = 0
		
	
func prev_alphabet() -> void:
	if active_alphabet != 0:
		active_alphabet -= 1
	else:
		active_alphabet = ALPHABET.size() - 1


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_up"):
		prev_alphabet()
	elif event.is_action_pressed("ui_down"):
		next_alphabet()
	elif event.is_action_pressed("ui_left"):
		move_left()
	elif event.is_action_pressed("ui_right"):
		move_right()
	
	get_viewport().set_input_as_handled()
	
	spinners[active_spinner].index = active_alphabet
	spinners[active_spinner].label.text = ALPHABET[active_alphabet]
	
	if event.is_action_pressed("ui_accept"):
		
		var name1 = name_label_1.text
		var name2 = name_label_2.text
		var name3 = name_label_3.text
		
		if name1 != "_" and name2 != "_" and name3 != "_":
			confirm_name.emit(name1 + name2 + name3)
