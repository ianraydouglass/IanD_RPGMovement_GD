extends StaticBody2D

@export var check_point_code: String = "none"
@export var is_default: bool = false
var manager
var spawn_anchor
var animation_tree

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_anchor = $SpawnAnchor
	animation_tree = $AnimationTree
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func register_check_point():
	var region = get_parent()
	region.check_point_in(self)
	refresh_point()

func refresh_point():
	if manager != null:
		if manager.check_if_current(self) == true:
			animation_tree["parameters/conditions/not_active"] = false
			animation_tree["parameters/conditions/active"] = true
		else:
			animation_tree["parameters/conditions/active"] = false
			animation_tree["parameters/conditions/not_active"] = true
			pass
	pass

func set_as_current():
	if manager != null:
		manager.code_as_current(self)
		animation_tree["parameters/conditions/not_active"] = false
		animation_tree["parameters/conditions/active"] = true
		var region = get_parent()
		region.refresh_local_check_points()
		manager.game_manager.collect.lock_keys()
		pass
	
	pass
