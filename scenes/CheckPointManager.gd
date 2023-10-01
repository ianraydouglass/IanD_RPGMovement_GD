extends Node2D


var all_check_points = []
var check_point_scene_index = []
var current_check_point: int = 0
var fall_back_check_point
var game_manager
#temporary respawn location
var respawn_location
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func register_check_point(c):
	if all_check_points.has(c.check_point_code):
		print("can't register check point, already has code " + c.check_point_code)
		return
	#record he unique check point code at the same time as the current scene index
	#this will allow us to load the level by index before spawning at the correct check point
	c.manager = self
	all_check_points.append(c.check_point_code)
	check_point_scene_index.append(game_manager.world_manager.current_scene_index)
#function to navigate to the check point location by code
#function for respawning at check point

func set_fall_back():
	if fall_back_check_point == null:
		fall_back_check_point = all_check_points[0]
		pass
	if respawn_location == null:
		code_as_current(get_check_point_node_by_code(fall_back_check_point))
		pass
	pass

func get_check_point_node_by_code(c):
	var point = game_manager.world_manager.current_level_scene.local_check_points[0]
	return point
	

func code_as_current(s):
	for i in all_check_points.size():
		if all_check_points[i] == s.check_point_code:
			current_check_point = i
			print("current check point set to " + s.check_point_code)
			respawn_location = s.spawn_anchor.global_transform.origin
			return

func respawn_to_world():
	var x = check_point_scene_index[current_check_point]
	game_manager.world_manager.respawn_to_checkpoint(x, respawn_location)
	pass
