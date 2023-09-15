extends Node2D

var move_direction: Vector2 = Vector2(0, 0)
var is_sprinting: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(Input.is_action_pressed("play_west"))
	move_direction = Input.get_vector("play_west", "play_east", "play_north", "play_south")
	is_sprinting = Input.is_action_pressed("play_sprint")
