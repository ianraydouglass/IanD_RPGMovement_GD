extends Node2D

var current_beat = -1
var p_group = []
var a_group = []
var current_act = -1
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func recieve_beat(b):
	if current_beat == b:
		return
	current_beat = b
	resolve_beat()

func resolve_beat():
	a_group = get_children()
	if a_group.size() > 0:
		for a in a_group.size():
			if a_group[a].has_method("check_beat"):
				var act_int = a_group[a].check_beat(current_beat)
				if act_int >= 0:
					current_act = act_int
		pass
	p_group = get_children()
	if p_group.size() > 0:
		for i in p_group.size():
			if p_group[i].has_method("set_beat_state"):
				p_group[i].set_beat_state(current_act)
				pass
	current_act = -1
