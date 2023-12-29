extends Node2D

var move_direction: Vector2 = Vector2(0, 0)
var is_sprinting: bool = false
var is_paused: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#expand to detect and swithc between game pad inputs and keyboard inputs dynamically later
	move_direction = Input.get_vector("play_west", "play_east", "play_north", "play_south")
	is_sprinting = Input.is_action_pressed("play_sprint")
	check_pause()

func check_pause():
	if Input.is_action_just_pressed("play_pause"):
		toggle_pause()

func toggle_pause():
	if is_paused == true:
		is_paused = false
		print("un-pause game")
	else:
		is_paused = true
		print("pause game")
