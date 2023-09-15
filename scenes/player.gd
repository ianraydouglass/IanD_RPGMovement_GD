extends Node2D

var input_manager

var speed: float = 100
var sprint_multi: float = 2
# Called when the node enters the scene tree for the first time.
func _ready():
	input_manager = $"../InputManager"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var current_speed: float = speed
	if input_manager.is_sprinting:
		current_speed = speed * sprint_multi
	position += input_manager.move_direction * current_speed * delta
