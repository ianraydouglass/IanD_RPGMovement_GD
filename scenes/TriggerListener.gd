extends Node2D

var current_state: bool = false
@export var control_paths = []
var control_zone = []
# Called when the node enters the scene tree for the first time.
func _ready():
	assign_zones()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func assign_zones():
	if control_paths.size() == 0:
		return
	for i in control_paths.size():
		var to_add = get_node(control_paths[i])
		control_zone.append(to_add)
	pass

func recieve_state(b):
	if b != current_state:
		current_state = b
		toggle_states()
		#do stuff

func toggle_states():
	if control_zone.size() == 0:
		return
	for i in control_zone.size():
		if control_zone[i].has_method("toggle_state"):
			control_zone[i].toggle_state()
