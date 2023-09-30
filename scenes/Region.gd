extends Node2D

var local_check_points = []
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func get_local_check_points():
	for c in get_children():
		if c.has_method("register_check_point"):
			c.register_check_point()

func check_point_in(p):
	local_check_points.append(p)
