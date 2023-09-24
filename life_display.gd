extends Node2D

var current_health: int = 5
var animation_tree: AnimationTree
# Called when the node enters the scene tree for the first time.
func _ready():
	animation_tree = $AnimationTree
	pass # Replace with function body.



func life_change(v: int):
	current_health = v
	update_life_tree()

func update_life_tree():
	if current_health < 5:
		animation_tree["parameters/conditions/current_life < 5"] = true
	else:
		animation_tree["parameters/conditions/current_life < 5"] = false
		
	if current_health < 4:
		animation_tree["parameters/conditions/current_life < 4"] = true
	else:
		animation_tree["parameters/conditions/current_life < 4"] = false
		
	if current_health < 3:
		animation_tree["parameters/conditions/current_life < 3"] = true
	else:
		animation_tree["parameters/conditions/current_life < 3"] = false
		
	if current_health < 2:
		animation_tree["parameters/conditions/current_life < 2"] = true
	else:
		animation_tree["parameters/conditions/current_life < 2"] = false
		
	if current_health < 1:
		animation_tree["parameters/conditions/current_life < 1"] = true
	else:
		animation_tree["parameters/conditions/current_life < 1"] = false
		
	if current_health > 0:
		animation_tree["parameters/conditions/current_life > 0"] = true
	else:
		animation_tree["parameters/conditions/current_life > 0"] = false
		
	if current_health > 1:
		animation_tree["parameters/conditions/current_life > 1"] = true
	else:
		animation_tree["parameters/conditions/current_life > 1"] = false
		
	if current_health > 2:
		animation_tree["parameters/conditions/current_life > 2"] = true
	else:
		animation_tree["parameters/conditions/current_life > 2"] = false
		
	if current_health > 3:
		animation_tree["parameters/conditions/current_life > 3"] = true
	else:
		animation_tree["parameters/conditions/current_life > 3"] = false
		
	if current_health > 4:
		animation_tree["parameters/conditions/current_life > 4"] = true
	else:
		animation_tree["parameters/conditions/current_life > 4"] = false
		
	
