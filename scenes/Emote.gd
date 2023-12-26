extends Node2D


var current_mode = "idle"
var animation_tree: AnimationTree
# Called when the node enters the scene tree for the first time.
func _ready():
	animation_tree = $AnimationTree
	pass # Replace with function body.



func mode_change(v):
	current_mode = v
	update_emote()
	

func update_emote():
	if current_mode == "gloat":
		animation_tree["parameters/conditions/gloat"] = true
	else:
		animation_tree["parameters/conditions/gloat"] = false
	if current_mode == "detect":
		animation_tree["parameters/conditions/detect"] = true
	else:
		animation_tree["parameters/conditions/detect"] = false
