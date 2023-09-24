extends Node2D

var current_health: int = 5
var animation_tree: AnimationTree
# Called when the node enters the scene tree for the first time.
func _ready():
	animation_tree = $AnimationTree
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func update_life_tree():
	if current_health >= 5:
		pass
	if current_health == 4:
		pass
	if current_health == 3:
		pass
	if current_health == 2:
		pass
	if current_health == 1:
		pass
	if current_health <= 0:
		pass
	animation_tree["parameters/conditions/current_life < 1"]
	pass
