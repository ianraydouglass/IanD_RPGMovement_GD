extends Node2D

var local_check_points = []
# Called when the node enters the scene tree for the first time.
@export var exit_points = []
var world_manager

func _ready():
	#set_exit_points()
	world_manager = $".."
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
	
func set_exit_points():
	if exit_points.size() < 1:
		return
	for e in exit_points:
		var n = get_node(e)
		if n.has_method("set_region"):
			n.set_region(self)
			print("exit point set")
